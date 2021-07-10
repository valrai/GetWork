defmodule Getwork.Languages.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.Candidates.Candidate

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "languages" do
    field :name, :string

    timestamps()

    many_to_many :candidates, Candidate, join_through: "candidate_languages"
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
  end
end
