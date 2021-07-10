defmodule Getwork.Repo.Migrations.CreateTableJobSkills do
  use Ecto.Migration

  def change do
    create table :job_skills, primary_key: false do
      add :job_offer_id, references(:job_offers, type: :uuid), primary_key: true
      add :skill_id, references(:skills, type: :uuid), primary_key: true

      timestamps()
    end
  end
end
