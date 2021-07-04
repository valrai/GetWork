defmodule Getwork.Repo.Migrations.CreateTableAddresses do
  use Ecto.Migration

  def change do
    create table :addresses, primary_key: false do
      add :id, :uuid, primary_key: true
      add :zip_code, :string, null: false, size: 12
      add :state, :string, null: false, size: 100
      add :city, :string, null: false, size: 100
      add :address_line_one, :string, null: false, size: 200
      add :address_line_two, :string, size: 200

      timestamps()
    end
  end
end
