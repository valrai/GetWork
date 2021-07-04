defmodule Getwork.Repo.Migrations.CreateTableCandidateSkills do
  use Ecto.Migration

  def change do
    create table :candidate_skills, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :skill, references(:skills, type: :string, name: :skill, column: :name), primary_key: true

      timestamps()
    end
  end
end
