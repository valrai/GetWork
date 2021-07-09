defmodule Getwork.WorkExperiences.WorkExperience do
  use Ecto.Schema
  import Ecto.Changeset

  alias Getwork.Candidates.Candidate
  alias Getwork.Enums

  @required_fields [
    :company_or_project,
    :type,
    :job_position,
    :current_job,
    :start_date,
    :description
  ]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "work_experiences" do
    field :type, Enums.WorkExperienceType
    field :company_or_project, :string
    field :current_job, :boolean, default: false
    field :description, :string
    field :job_position, :string
    field :start_date, :date
    field :end_date, :date

    belongs_to :candidate, Candidate

    timestamps()
  end

  @doc false
  def changeset(work_experience, attrs) do
    work_experience
    |> cast(attrs, [:end_date, :candidate_id] ++ @required_fields)
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required(@required_fields)
    |> validate_length(:company_or_project, max: 200)
    |> validate_length(:job_position, max: 100)
    |> foreign_key_constraint(:candidate_id)
  end
end
