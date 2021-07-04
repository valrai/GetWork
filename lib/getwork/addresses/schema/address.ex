defmodule Getwork.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.Addresses.Address

  @required_fields [:zip_code, :state, :city, :address_line_one]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "addresses" do
    field :zip_code, :string
    field :state, :string
    field :city, :string
    field :address_line_one, :string
    field :address_line_two, :string

    has_one :address, Address

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:address_line_two | @required_fields])
    |> validate()
  end

  defp validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> validate_length(:zip_code, min: 4, max: 12)
    |> validate_length(:state, max: 100)
    |> validate_length(:city, max: 100)
    |> validate_length(:address_line_one, max: 200)
    |> validate_length(:address_line_two, max: 200)
  end
end
