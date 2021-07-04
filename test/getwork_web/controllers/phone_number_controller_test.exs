defmodule GetworkWeb.PhoneNumberControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.PhoneNumbers
  alias Getwork.PhoneNumbers.PhoneNumber

  @create_attrs %{
    phone: "some phone"
  }
  @update_attrs %{
    phone: "some updated phone"
  }
  @invalid_attrs %{phone: nil}

  def fixture(:phone_number) do
    {:ok, phone_number} = PhoneNumbers.create_phone_number(@create_attrs)
    phone_number
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all phone_numbers", %{conn: conn} do
      conn = get(conn, Routes.phone_number_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create phone_number" do
    test "renders phone_number when data is valid", %{conn: conn} do
      conn = post(conn, Routes.phone_number_path(conn, :create), phone_number: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.phone_number_path(conn, :show, id))

      assert %{
               "id" => id,
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.phone_number_path(conn, :create), phone_number: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update phone_number" do
    setup [:create_phone_number]

    test "renders phone_number when data is valid", %{conn: conn, phone_number: %PhoneNumber{id: id} = phone_number} do
      conn = put(conn, Routes.phone_number_path(conn, :update, phone_number), phone_number: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.phone_number_path(conn, :show, id))

      assert %{
               "id" => id,
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, phone_number: phone_number} do
      conn = put(conn, Routes.phone_number_path(conn, :update, phone_number), phone_number: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete phone_number" do
    setup [:create_phone_number]

    test "deletes chosen phone_number", %{conn: conn, phone_number: phone_number} do
      conn = delete(conn, Routes.phone_number_path(conn, :delete, phone_number))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.phone_number_path(conn, :show, phone_number))
      end
    end
  end

  defp create_phone_number(_) do
    phone_number = fixture(:phone_number)
    %{phone_number: phone_number}
  end
end
