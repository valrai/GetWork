defmodule Getwork.Repo.Migrations.CreateTableJobSkills do
  use Ecto.Migration

  def change do
    create table :job_skills do
      add :job_offer_id, references(:job_offers, type: :uuid), primary_key: true
      addd :skill, references(:skills, type: :string, name: :skill, column: :name), primary_key: true

      timestamps()
    end
  end
end
