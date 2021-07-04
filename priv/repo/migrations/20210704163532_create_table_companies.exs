defmodule Getwork.Repo.Migrations.CreateTableCompanies do
  use Ecto.Migration

  def change do
    create table :companies, primary_key: false do
      add :id, :uuid, primary_key: true
      add :ein, :string, size: 9, null: false
      add :name, :string, size: 100, null: false
      add :trade_name, :string, size: 200, null: false
      add :link, :string, size: 200
      add :picture_ul, :string

      add :user_id, references(:users, type: :uuid), null: false
      add :address_id, references(:addresses, type: :uuid), null: false

      timestamps()
    end
  end
end
