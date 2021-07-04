defmodule Getwork.PhoneNumbers.PhoneNumber do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:phone, :string, []}
  @derive {Phoenix.Param, key: :phone}

  schema "phone_numbers" do
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
