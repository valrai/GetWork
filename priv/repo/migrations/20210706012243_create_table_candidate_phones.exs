defmodule Getwork.Repo.Migrations.CreateTableCandidatePhones do
  use Ecto.Migration

  def change do
    create table :candidate_phones, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :phone_number_id, references(:phone_numbers, type: :uuid), primary_key: true
    end
  end
end
