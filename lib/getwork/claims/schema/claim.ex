defmodule Getwork.Claims.Claim do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.Roles.Role

  @primary_key {:name, :string, []}
  @derive {Phoenix.Param, key: :name}

  schema "claims" do
    many_to_many :roles, Role,
      join_through: "role_claims",
      join_keys: [claim: :name, role: :name]

    timestamps()
  end

  @doc false
  def changeset(claim, attrs) do
    claim
    |> cast(attrs, [:name])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
  end
end
