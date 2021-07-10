defmodule Getwork.Repo.Migrations.CreateTableSkills do
  use Ecto.Migration

  def change do
    create table :skills, primary_key: false do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 50, null: false

      timestamps()
    end
  end
end
