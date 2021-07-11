defmodule GetworkWeb.RoleController.CreateTest do
  use GetworkWeb.ConnCase, async: true

  describe "create" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should create a new role.", %{conn: conn} do
      role = %{"name" => "valid name"}

      conn = post(conn, Routes.role_path(conn, :create), role)
      response_data = json_response(conn, 201)["data"]

      refute is_nil(response_data["id"])
      assert response_data["name"] == role["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{conn: conn} do
      conn = post(conn, Routes.role_path(conn, :create), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end
  end
end
