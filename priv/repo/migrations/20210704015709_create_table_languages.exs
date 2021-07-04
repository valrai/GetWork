defmodule Getwork.Repo.Migrations.CreateTableLanguages do
  use Ecto.Migration

  def change do
    create table :languages,  primary_key: false  do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
