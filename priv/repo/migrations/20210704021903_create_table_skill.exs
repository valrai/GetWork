defmodule Getwork.Repo.Migrations.CreateTableSkill do
  use Ecto.Migration

  def change do
    create table :skill, primary_key: false do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
