defmodule Getwork.Repo.Migrations.CreateTablePhoneNumbers do
  use Ecto.Migration

  def change do
    create table :phone_numbers, primary_key: false do
      add :phone, :string, primary_key: true, size: 15

      timestamps()
    end
  end
end
