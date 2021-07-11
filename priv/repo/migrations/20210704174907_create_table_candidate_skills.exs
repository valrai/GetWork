defmodule Getwork.Repo.Migrations.CreateTableCandidateSkills do
  use Ecto.Migration

  def change do
    create table :candidate_skills, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :skill_id, references(:skills, type: :uuid), primary_key: true
    end
  end
end
