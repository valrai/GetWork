defmodule Getwork.Repo.Migrations.CreateTableCandidatePhones do
  use Ecto.Migration

  def change do
    create table :candidate_phones, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :phone_number, references(:phone_numbers, type: :string, name: :phone_number, column: :phone), primary_key: true

      timestamps()
    end
  end
end
