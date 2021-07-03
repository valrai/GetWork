defmodule Getwork.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:name, :string, []}
  @derive {Phoenix.Param, key: :name}

  schema "roles" do
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
  end
end
