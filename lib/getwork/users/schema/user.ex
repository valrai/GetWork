defmodule Getwork.Users.User do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]

  alias Getwork.Candidates.Candidate
  alias Getwork.Companies.Company
  alias Getwork.Roles.Role
  alias Getwork.Repo

  @required_fields [:email, :username]
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @derive {Inspect, except: [:password, :password_hash]}

  schema "users" do
    field :email, :string
    field :is_active, :boolean, default: true
    field :password, :string, virtual: true
    field :password_hash, :string
    field :suspension_end_date, :date
    field :username, :string

    many_to_many :roles, Role, join_through: "user_roles", on_replace: :delete

    has_one :candidate, Candidate
    has_one :company, Company

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:password | @required_fields])
    |> put_password_hash()
    |> maybe_put_roles(attrs)
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:email, max: 200)
    |> validate_length(:password, min: 6)
    |> validate_length(:username, max: 50)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        changeset
        |> Ecto.Changeset.delete_change(:password)
        |> put_change(:password_hash, hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end

  defp maybe_put_roles(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :roles), do: :roles, else: "roles"

    case Map.get(attrs, field_name) do
      nil ->
        changeset

      roles ->
        roles =
          Role
          |> where([r], r.id in ^roles)
          |> Repo.all()

        put_assoc(changeset, :roles, roles)
    end
  end
end
