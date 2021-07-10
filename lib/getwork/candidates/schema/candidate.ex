defmodule Getwork.Candidates.Candidate do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Users.User
  alias Getwork.WorkExperiences.WorkExperience
  alias Getwork.Addresses.Address
  alias Getwork.PhoneNumbers.PhoneNumber
  alias Getwork.JobOffers.JobOffer
  alias Getwork.Languages.Language
  alias Getwork.WorkExperiences.WorkExperience
  alias Getwork.Qualifications.Education
  alias Getwork.Skills.Skill

  @required_fields [:nin, :name, :last_name]
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "candidates" do
    field :nin, :string
    field :name, :string
    field :last_name, :string
    field :picture_url, :string
    field :link, :string

    many_to_many :phones, PhoneNumber, join_through: "candidate_phones"
    many_to_many :languages, Language, join_through: "candidate_languages"
    many_to_many :skills, Skill, join_through: "candidate_skills"
    many_to_many :applications, JobOffer, join_through: "applications"
    has_many :work_experiences, WorkExperience
    has_many :education, Education
    belongs_to :user, User
    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, @required_fields ++ [:link, :picture_url, :user_id, :address_id])
    |> cast_assoc(:work_experiences, &WorkExperience.changeset/2)
    |> cast_assoc(:education, &Education.changeset/2)
    |> maybe_put_languages(attrs)
    |> maybe_put_phones(attrs)
    |> maybe_put_skills(attrs)
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_length(:name, max: 100)
    |> validate_length(:last_name, max: 200)
    |> validate_length(:last_name, max: 11)
    |> validate_length(:link, max: 200)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:address_id)
    |> foreign_key_constraint(:user_id)
  end

  defp maybe_put_languages(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :languages), do: :languages, else: "languages"

    case Map.get(attrs, field_name) do
      nil -> changeset
      languages -> put_assoc(changeset, :languages, languages)
    end
  end

  defp maybe_put_phones(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :phones), do: :phones, else: "phones"

    case Map.get(attrs, field_name) do
      nil -> changeset
      phones -> put_assoc(changeset, :phones, phones)
    end
  end

  defp maybe_put_skills(changeset, attrs) do
    field_name = if Map.has_key?(attrs, :skills), do: :skills, else: "skills"

    case Map.get(attrs, field_name) do
      nil -> changeset
      skills -> put_assoc(changeset, :skills, skills)
    end
  end
end
