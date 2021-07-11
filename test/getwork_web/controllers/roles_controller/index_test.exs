defmodule GetworkWeb.RoleController.IndexTest do
  use GetworkWeb.ConnCase, async: true
  import Getwork.Factory

  describe "list_roles" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should list all registered roles.", %{conn: conn} do
      insert!(:role)
      insert!(:role)
      insert!(:role)

      conn = get(conn, Routes.role_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 3
    end

    test "should return a empty list if no role is found.", %{conn: conn} do
      conn = get(conn, Routes.role_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end
end
