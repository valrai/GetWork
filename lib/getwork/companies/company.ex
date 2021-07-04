defmodule Getwork.Companies.Company do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Addresses.Address
  alias Getwork.Users.User

  @required_fields [:ein, :name, :trade_name]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "companies" do
    field :ein, :string
    field :link, :string
    field :name, :string
    field :picture_ul, :string
    field :trade_name, :string

    belongs_to :address, Address
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:link, :picture_ul] ++ @required_fields)
    |> validate()
  end

  defp validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> validate_length(:ein, min: 9, max: 9)
    |> validate_length(:link, max: 200)
    |> validate_length(:name, max: 200)
    |> validate_length(:trade_name, max: 100)
    |> foreign_key_constraint(:address_id)
    |> foreign_key_constraint(:user_id)
  end
end
