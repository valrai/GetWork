defmodule Getwork.JobOffers.JobOffer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.Companies.Company

  @required_fields [
    :title,
    :description,
    :number_of_positions,
    :start_date,
    :end_date,
    :is_filled
  ]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "job_offers" do
    field :description, :string
    field :end_date, :date
    field :is_filled, :boolean, default: false
    field :number_of_positions, :integer, default: 1
    field :start_date, :date
    field :title, :string

    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(job_offer, attrs) do
    job_offer
    |> cast(attrs, @required_fields)
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> validate_length(:title, max: 200)
  end
end
