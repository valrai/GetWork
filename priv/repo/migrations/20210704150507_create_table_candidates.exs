defmodule Getwork.Repo.Migrations.CreateTableCandidates do
  use Ecto.Migration

  def change do
    create table :candidates, primary_key: false do
      add :id, :uuid, primary_key: true
      add :nin, :string, size: 11, null: false
      add :name, :string, size: 100, null: false
      add :last_name, :string, size: 200, null: false
      add :link, :string, size: 200
      add :picture_url, :string

      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      add :address_id, references(:addresses, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
