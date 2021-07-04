defmodule Getwork.CompaniesTest do
  use Getwork.DataCase

  alias Getwork.Companies

  describe "companies" do
    alias Getwork.Companies.Company

    @valid_attrs %{ein: "some ein", link: "some link", name: "some name", picture_ul: "some picture_ul", trade_name: "some trade_name"}
    @update_attrs %{ein: "some updated ein", link: "some updated link", name: "some updated name", picture_ul: "some updated picture_ul", trade_name: "some updated trade_name"}
    @invalid_attrs %{ein: nil, link: nil, name: nil, picture_ul: nil, trade_name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Companies.create_company(@valid_attrs)
      assert company.ein == "some ein"
      assert company.link == "some link"
      assert company.name == "some name"
      assert company.picture_ul == "some picture_ul"
      assert company.trade_name == "some trade_name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Companies.update_company(company, @update_attrs)
      assert company.ein == "some updated ein"
      assert company.link == "some updated link"
      assert company.name == "some updated name"
      assert company.picture_ul == "some updated picture_ul"
      assert company.trade_name == "some updated trade_name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end
end
