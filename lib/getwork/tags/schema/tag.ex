defmodule Getwork.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Getwork.JobOffers.JobOffer

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "tags" do
    field :name, :string

    many_to_many :jobs, JobOffer, join_through: "job_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate()
  end

  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 50)
  end
end
