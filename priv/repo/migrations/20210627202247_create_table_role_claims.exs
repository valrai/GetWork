defmodule Getwork.Repo.Migrations.CreateTableRoleClaims do
  use Ecto.Migration

  def change do
    create table :role_claims, primary_key: false do
      add :claim, references(:claims, type: :string, name: :claim, column: :name), primary_key: true
      add :role, references(:roles, type: :string, name: :role, column: :name), primary_key: true

      timestamps()
    end
  end
end
