defmodule Getwork.Repo.Migrations.CreateTableClaims do
  use Ecto.Migration

  def change do
    create table :claims, primary_key: false do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
