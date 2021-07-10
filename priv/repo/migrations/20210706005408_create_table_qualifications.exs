defmodule Getwork.Repo.Migrations.CreateTableQualifications do
  use Ecto.Migration
  alias Getwork.Enums

  def change do
    Enums.EducationLevel.create_type()

    create table :education, primary_key: false do
      add :id, :uuid, primary_key: true
      add :type, Enums.EducationLevel.type(), null: false
      add :institution, :string, size: 200, null: false
      add :city, :string, size: 200, null: false
      add :its_currently_attending, :boolean, default: false, null: false
      add :start_date, :date, null: false
      add :end_date, :date

      add :candidate_id, references(:candidates, type: :uuid), null: false

      timestamps()
    end
  end
end
