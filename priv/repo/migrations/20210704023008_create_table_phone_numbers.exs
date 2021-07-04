defmodule Getwork.Repo.Migrations.CreateTablePhoneNumbers do
  use Ecto.Migration

  def change do
    create table :phone_numbers, primary_key: false do
      add :phone, :string, primary_key: true

      timestamps()
    end
  end
end
