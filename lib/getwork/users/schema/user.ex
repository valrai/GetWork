defmodule Getwork.Users.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :email, :string
    field :is_active, :boolean, default: false
    field :password, :string
    field :password_hash, :string, virtual: true
    field :suspension_end_date, :naive_datetime
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_hash, :username, :is_active, :suspension_end_date])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:email, :password, :username, :is_active])
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:email, max: 200)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end
end