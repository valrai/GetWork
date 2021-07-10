defmodule Getwork.Skills.Skill do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.JobOffers.JobOffer
  alias Getwork.Candidates.Candidate

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "skills" do
    field :name, :string

    many_to_many :jobs, JobOffer, join_through: "job_skills"
    many_to_many :candidate, Candidate, join_through: "candidate_skills"

    timestamps()
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
  end
end
