defmodule Getwork.Repo.Migrations.CreateTableJobOffers do
  use Ecto.Migration

  def change do
    create table :job_offers, primary_key: false do
      add :id, :uuid, primary_key: true
      add :title, :string, size: 100, null: false
      add :description, :text, null: false
      add :number_of_positions, :integer, default: 1, null: false
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :is_filled, :boolean, default: false, null: false

      add :company_id, references(:companies, type: :uuid), null: false

      timestamps()
    end
  end
end
