defmodule Getwork.Repo.Migrations.CreateTableJobTags do
  use Ecto.Migration

  def change do
    create table :job_tags, primary_key: false do
      add :job_offer_id, references(:job_offers, type: :uuid), primary_key: true
      add :tag_id, references(:tags, type: :uuid), primary_key: true

      timestamps()
    end
  end
end
