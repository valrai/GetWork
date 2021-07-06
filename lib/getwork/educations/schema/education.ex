defmodule Getwork.Educations.Education do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Candidates.Candidate
  alias Getwork.Enums

  @required_fields [:type, :institution, :city, :its_currently_attending, :start_date]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "educations" do
    field :city, :string
    field :end_date, :date
    field :institution, :string
    field :its_currently_attending, :boolean, default: false
    field :start_date, :date
    field :type, Enums.EducationLevel

    belongs_to :candidate, Candidate

    timestamps()
  end

  @doc false
  def changeset(education, attrs) do
    education
    |> cast(attrs, [:end_date | @required_fields])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:candidate_id)
    |> validate_length(:institution, max: 200)
    |> validate_length(:city, max: 200)
  end
end
