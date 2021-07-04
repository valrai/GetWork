defmodule Getwork.Repo.Migrations.CreateTableSkills do
  use Ecto.Migration

  def change do
    create table :skills, primary_key: false do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
