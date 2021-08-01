defmodule Getwork.Repo.Migrations.CreateTableUserRoles do
  use Ecto.Migration

  def change do
    create table :user_roles, primary_key: false do
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), primary_key: true
      add :role_id, references(:roles, type: :uuid, on_delete: :delete_all), primary_key: true
    end
  end
end
