defmodule Getwork.Factory do
  alias Getwork.Languages.Language
  alias Getwork.Tags.Tag
  alias Getwork.Repo

  def build(:language) do
    %Language{name: Faker.Lorem.word()}
  end

  def build(:tag) do
    %Tag{name: Faker.Lorem.word()}
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
