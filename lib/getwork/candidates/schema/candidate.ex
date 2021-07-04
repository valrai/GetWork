defmodule Getwork.Candidates.Candidate do
  use Ecto.Schema

  import Ecto.Changeset

  alias Getwork.Users.User
  alias Getwork.Addresses.Address

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @required_fields [:nin, :name, :last_name]

  schema "candidates" do
    field :nin, :string
    field :name, :string
    field :last_name, :string
    field :picture_url, :string
    field :link, :string

    belongs_to :user, User
    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:link, :picture_url] ++ @required_fields)
    |> validate_length(:name, max: 100)
    |> validate_length(:last_name, max: 200)
    |> validate_length(:last_name, max: 11)
    |> validate_length(:link, max: 200)
    |> validate_required(@required_fields)
  end
end
