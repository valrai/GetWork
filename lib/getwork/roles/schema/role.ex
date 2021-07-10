defmodule Getwork.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.Claims.Claim

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "roles" do
    field :name, :string

    many_to_many :claims, Claim, join_through: "role_claims"

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> maybe_put_claims(attrs)
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
  end

  defp maybe_put_claims(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :claims), do: :claims, else: "claims"

    case Map.get(attrs, field_name) do
      nil -> changeset
      claims -> put_assoc(changeset, :claims, claims)
    end
  end
end
