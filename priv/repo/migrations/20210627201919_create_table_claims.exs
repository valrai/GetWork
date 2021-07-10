defmodule Getwork.Repo.Migrations.CreateTableClaims do
  use Ecto.Migration

  def change do
    create table :claims, primary_key: false do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 100, null: false

      timestamps()
    end
  end
end
