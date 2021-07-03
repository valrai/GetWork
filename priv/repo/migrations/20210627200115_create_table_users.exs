defmodule Getwork.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration

  def change do
    create table :users, primary_key: false do
      add :id, :uuid, primary_key: true
      add :email, :string, size: 200, null: false
      add :password, :string
      add :password_hash, :string
      add :username, :string, size: 50, null: false
      add :is_active, :boolean, default: false, null: false
      add :suspension_end_date, :naive_datetime

      timestamps()
    end

    create unique_index :users, [:email]
    create unique_index :users, [:username]
  end
end