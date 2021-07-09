defmodule Getwork.Repo.Migrations.CreateTableJobTags do
  use Ecto.Migration

  def change do
    create table :job_tags do
      add :job_offer_id, references(:job_offers, type: :uuid), primary_key: true
      add :tag, references(:tags, type: :string, name: :tag, column: :name), primary_key: true

      timestamps()
    end
  end
end
