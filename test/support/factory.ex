defmodule Getwork.Factory do
  alias Getwork.Languages.Language
  alias Getwork.Tags.Tag
  alias Getwork.Skills.Skill
  alias Getwork.Claims.Claim
  alias Getwork.Roles.Role
  alias Getwork.Users.User
  alias Getwork.Candidates.Candidate
  alias Getwork.Companies.Company
  alias Getwork.Addresses.Address
  alias Getwork.Repo

  def build(:language) do
    %Language{name: Faker.Lorem.word()}
  end

  def build(:tag) do
    %Tag{name: Faker.Lorem.word()}
  end

  def build(:skill) do
    %Skill{name: Faker.Lorem.word()}
  end

  def build(:claim) do
    %Claim{name: Faker.Lorem.word()}
  end

  def build(:role) do
    %Role{name: Faker.Lorem.word()}
  end

  def build(:user) do
    %User{
      email: Faker.Internet.email(),
      username: Faker.Internet.user_name(),
      password: Faker.Util.format("%3d%3b"),
      password_hash: Faker.UUID.v4(),
      roles: []
    }
  end

  def build(:address) do
    %Address{
      zip_code: Faker.Address.zip_code(),
      state: Faker.Address.state(),
      city: Faker.Address.city(),
      address_line_one: Faker.Address.street_address(),
      address_line_two: Faker.Address.secondary_address()
    }
  end

  def build(:candidate) do
    %{id: address_id} = insert!(:address)

    %Candidate{
      nin: Faker.Util.format("%2A%6d%1A"),
      name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      picture_url: Faker.Internet.url(),
      link: Faker.Internet.url(),
      address_id: address_id
    }
  end

  def build(:company) do
    %{id: address_id} = insert!(:address)

    %Company{
      ein: Faker.Util.format("%9d"),
      name: Faker.Company.name(),
      trade_name: Faker.Company.name(),
      picture_url: Faker.Internet.url(),
      link: Faker.Internet.url(),
      address_id: address_id
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
