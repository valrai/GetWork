defmodule Getwork.PhoneNumbers.PhoneNumber do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Candidates.Candidate
  alias Getwork.Companies.Company

  @primary_key {:phone, :string, []}
  @derive {Phoenix.Param, key: :phone}

  schema "phone_numbers" do
    many_to_many :candidates, Candidate,
      join_through: "candidate_phones",
      join_keys: [phone_number: :phone, candidate_id: :id]

    many_to_many :companies, Company,
      join_through: "company_phones",
      join_keys: [phone_number: :phone, company_id: :id]

    timestamps()
  end

  @doc false
  def changeset(phone_number, attrs) do
    phone_number
    |> cast(attrs, [:phone])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:phone])
    |> validate_length(:phone, max: 15)
  end
end
