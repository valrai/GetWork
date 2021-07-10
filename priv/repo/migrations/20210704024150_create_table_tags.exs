defmodule Getwork.Repo.Migrations.CreateTableTags do
  use Ecto.Migration

  def change do
    create table :tags, primary_key: false  do
      add :id, :uuid, primary_key: true
      add :name, :string,  size: 50, null: false

      timestamps()
    end
  end
end
