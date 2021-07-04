defmodule Getwork.AddressesTest do
  use Getwork.DataCase

  alias Getwork.Addresses

  describe "addresses" do
    alias Getwork.Addresses.Address

    @valid_attrs %{address_line_one: "some address_line_one", address_line_two: "some address_line_two", city: "some city", state: "some state", zip_code: "some zip_code"}
    @update_attrs %{address_line_one: "some updated address_line_one", address_line_two: "some updated address_line_two", city: "some updated city", state: "some updated state", zip_code: "some updated zip_code"}
    @invalid_attrs %{address_line_one: nil, address_line_two: nil, city: nil, state: nil, zip_code: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Addresses.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Addresses.create_address(@valid_attrs)
      assert address.address_line_one == "some address_line_one"
      assert address.address_line_two == "some address_line_two"
      assert address.city == "some city"
      assert address.state == "some state"
      assert address.zip_code == "some zip_code"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Addresses.update_address(address, @update_attrs)
      assert address.address_line_one == "some updated address_line_one"
      assert address.address_line_two == "some updated address_line_two"
      assert address.city == "some updated city"
      assert address.state == "some updated state"
      assert address.zip_code == "some updated zip_code"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
