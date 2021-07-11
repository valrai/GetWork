defmodule Getwork.Repo.Migrations.CreateTableUserRoles do
  use Ecto.Migration

  def change do
    create table :user_roles, primary_key: false do
      add :user_id, references(:users, type: :uuid), primary_key: true
      add :role_id, references(:roles, type: :uuid), primary_key: true
    end
  end
end
