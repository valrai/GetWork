defmodule GetworkWeb.CompanyControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.Companies
  alias Getwork.Companies.Company

  @create_attrs %{
    ein: "some ein",
    link: "some link",
    name: "some name",
    picture_ul: "some picture_ul",
    trade_name: "some trade_name"
  }
  @update_attrs %{
    ein: "some updated ein",
    link: "some updated link",
    name: "some updated name",
    picture_ul: "some updated picture_ul",
    trade_name: "some updated trade_name"
  }
  @invalid_attrs %{ein: nil, link: nil, name: nil, picture_ul: nil, trade_name: nil}

  def fixture(:company) do
    {:ok, company} = Companies.create_company(@create_attrs)
    company
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get(conn, Routes.company_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company" do
    test "renders company when data is valid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      assert %{
               "id" => id,
               "ein" => "some ein",
               "link" => "some link",
               "name" => "some name",
               "picture_ul" => "some picture_ul",
               "trade_name" => "some trade_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company" do
    setup [:create_company]

    test "renders company when data is valid", %{conn: conn, company: %Company{id: id} = company} do
      conn = put(conn, Routes.company_path(conn, :update, company), company: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      assert %{
               "id" => id,
               "ein" => "some updated ein",
               "link" => "some updated link",
               "name" => "some updated name",
               "picture_ul" => "some updated picture_ul",
               "trade_name" => "some updated trade_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put(conn, Routes.company_path(conn, :update, company), company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, Routes.company_path(conn, :delete, company))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.company_path(conn, :show, company))
      end
    end
  end

  defp create_company(_) do
    company = fixture(:company)
    %{company: company}
  end
end
