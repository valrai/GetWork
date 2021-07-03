defmodule Getwork.Repo.Migrations.CreateTableRoles do
  use Ecto.Migration

  def change do
    create table :roles, primary_key: false do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
