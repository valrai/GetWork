defmodule Getwork.Companies.Company do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Addresses.Address
  alias Getwork.PhoneNumbers.PhoneNumber
  alias Getwork.Users.User

  @required_fields [:ein, :name, :trade_name]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "companies" do
    field :ein, :string
    field :link, :string
    field :name, :string
    field :picture_ul, :string
    field :trade_name, :string

    many_to_many :phones, PhoneNumber,
      join_through: "company_phones",
      join_keys: [company_id: :id, phone_number: :phone]

    belongs_to :address, Address
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @required_fields ++ [:link, :picture_ul, :user_id, :address_id])
    |> maybe_put_phones(attrs)
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

  defp maybe_put_phones(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :phones), do: :phones, else: "phones"

    case Map.get(attrs, field_name) do
      nil -> changeset
      phones -> put_assoc(changeset, :phones, phones)
    end
  end
end
