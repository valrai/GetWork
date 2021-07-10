defmodule Getwork.Repo.Migrations.CreateTablePhoneNumbers do
  use Ecto.Migration

  def change do
    create table :phone_numbers, primary_key: false do
      add :id, :uuid, primary_key: true
      add :phone, :string, size: 15, null: false

      timestamps()
    end
  end
end
