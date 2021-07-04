defmodule Getwork.Repo.Migrations.CreateTableCandidateLanguages do
  use Ecto.Migration

  def change do
    create table :candidate_languages, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :language, references(:languages, type: :string, name: :language, column: :name), primary_key: true

      timestamps()
    end
  end
end