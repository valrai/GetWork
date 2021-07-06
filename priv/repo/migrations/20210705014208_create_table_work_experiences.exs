defmodule Getwork.Repo.Migrations.CreateTableWorkExperiences do
  use Ecto.Migration
  alias Getwork.Enums

  def change do
    Enums.WorkExperienceType.create_type()

    create table :work_experiences, primary_key: false do
      add :id, :uuid, primary_key: true
      add :company_or_project, :string, size: 200, null: false
      add :type, Enums.WorkExperienceType.type()
      add :job_position, :string, size: 100, null: false
      add :current_job, :boolean, default: false, null: false
      add :start_date, :date, null: false
      add :end_date, :date
      add :description, :text, null: false

      add :candidate_id, references(:candidates, type: :uuid), primary_key: true

      timestamps()
    end
  end
end
