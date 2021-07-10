defmodule Getwork.Repo.Migrations.CreateTableRoleClaims do
  use Ecto.Migration

  def change do
    create table :role_claims, primary_key: false do
      add :claim_id, references(:claims, type: :uuid), primary_key: true
      add :role_id, references(:roles, type: :uuid), primary_key: true

      timestamps()
    end
  end
end
