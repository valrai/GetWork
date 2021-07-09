defmodule Getwork.Repo.Migrations.CreateTableTags do
  use Ecto.Migration

  def change do
    create table :tags, primary_key: false  do
      add :name, :string, primary_key: true, size: 50

      timestamps()
    end
  end
end
