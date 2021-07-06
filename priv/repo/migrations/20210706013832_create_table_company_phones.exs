defmodule Getwork.Repo.Migrations.CreateTableCompanyPhones do
  use Ecto.Migration

  def change do
    create table :company_phones, primary_key: false do
      add :company_id, references(:companies, type: :uuid), primary_key: true
      add :phone_number, references(:phone_numbers, type: :string, name: :phone_number, column: :phone), primary_key: true

      timestamps()
    end
  end
end
