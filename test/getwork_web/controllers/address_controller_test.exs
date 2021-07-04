defmodule GetworkWeb.AddressControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.Addresses
  alias Getwork.Addresses.Address

  @create_attrs %{
    address_line_one: "some address_line_one",
    address_line_two: "some address_line_two",
    city: "some city",
    state: "some state",
    zip_code: "some zip_code"
  }
  @update_attrs %{
    address_line_one: "some updated address_line_one",
    address_line_two: "some updated address_line_two",
    city: "some updated city",
    state: "some updated state",
    zip_code: "some updated zip_code"
  }
  @invalid_attrs %{address_line_one: nil, address_line_two: nil, city: nil, state: nil, zip_code: nil}

  def fixture(:address) do
    {:ok, address} = Addresses.create_address(@create_attrs)
    address
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => id,
               "address_line_one" => "some address_line_one",
               "address_line_two" => "some address_line_two",
               "city" => "some city",
               "state" => "some state",
               "zip_code" => "some zip_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => id,
               "address_line_one" => "some updated address_line_one",
               "address_line_two" => "some updated address_line_two",
               "city" => "some updated city",
               "state" => "some updated state",
               "zip_code" => "some updated zip_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, Routes.address_path(conn, :delete, address))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.address_path(conn, :show, address))
      end
    end
  end

  defp create_address(_) do
    address = fixture(:address)
    %{address: address}
  end
end
