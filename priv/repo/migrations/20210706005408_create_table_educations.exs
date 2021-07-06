defmodule Getwork.Repo.Migrations.CreateTableEducations do
  use Ecto.Migration
  alias Getwork.Enums

  def change do
    Enums.EducationLevel.create_type()

    create table :educations do
      add :type, Enums.EducationLevel.type(), null: false
      add :institution, :string, size: 200, null: false
      add :city, :string, size: 200, null: false
      add :its_currently_attending, :boolean, default: false, null: false
      add :start_date, :date, null: false
      add :end_date, :date

      timestamps()
    end
  end
end
