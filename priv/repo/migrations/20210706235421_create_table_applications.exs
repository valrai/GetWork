defmodule Getwork.Repo.Migrations.CreateTableApplications do
  use Ecto.Migration

  def change do
    create table :aplications, primary_key: false do
      add :candidate_id, references(:candidates, type: :uuid), primary_key: true
      add :job_offer_id, references(:job_offers, type: :uuid), primary_key: true

      timestamps()
    end
  end
end
