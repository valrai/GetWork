defmodule Getwork.PhoneNumbersTest do
  use Getwork.DataCase

  alias Getwork.PhoneNumbers

  describe "phone_numbers" do
    alias Getwork.PhoneNumbers.PhoneNumber

    @valid_attrs %{phone: "some phone"}
    @update_attrs %{phone: "some updated phone"}
    @invalid_attrs %{phone: nil}

    def phone_number_fixture(attrs \\ %{}) do
      {:ok, phone_number} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PhoneNumbers.create_phone_number()

      phone_number
    end

    test "list_phone_numbers/0 returns all phone_numbers" do
      phone_number = phone_number_fixture()
      assert PhoneNumbers.list_phone_numbers() == [phone_number]
    end

    test "get_phone_number!/1 returns the phone_number with given id" do
      phone_number = phone_number_fixture()
      assert PhoneNumbers.get_phone_number!(phone_number.id) == phone_number
    end

    test "create_phone_number/1 with valid data creates a phone_number" do
      assert {:ok, %PhoneNumber{} = phone_number} = PhoneNumbers.create_phone_number(@valid_attrs)
      assert phone_number.phone == "some phone"
    end

    test "create_phone_number/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PhoneNumbers.create_phone_number(@invalid_attrs)
    end

    test "update_phone_number/2 with valid data updates the phone_number" do
      phone_number = phone_number_fixture()
      assert {:ok, %PhoneNumber{} = phone_number} = PhoneNumbers.update_phone_number(phone_number, @update_attrs)
      assert phone_number.phone == "some updated phone"
    end

    test "update_phone_number/2 with invalid data returns error changeset" do
      phone_number = phone_number_fixture()
      assert {:error, %Ecto.Changeset{}} = PhoneNumbers.update_phone_number(phone_number, @invalid_attrs)
      assert phone_number == PhoneNumbers.get_phone_number!(phone_number.id)
    end

    test "delete_phone_number/1 deletes the phone_number" do
      phone_number = phone_number_fixture()
      assert {:ok, %PhoneNumber{}} = PhoneNumbers.delete_phone_number(phone_number)
      assert_raise Ecto.NoResultsError, fn -> PhoneNumbers.get_phone_number!(phone_number.id) end
    end

    test "change_phone_number/1 returns a phone_number changeset" do
      phone_number = phone_number_fixture()
      assert %Ecto.Changeset{} = PhoneNumbers.change_phone_number(phone_number)
    end
  end
end
