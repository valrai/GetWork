defmodule GetworkWeb.RoleController.DeleteTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Roles.Role

  describe "delete_role" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should remove the correct role.", %{conn: conn} do
      %{id: first_role_id} = insert!(:role)
      %{id: second_role_id} = insert!(:role)

      conn = delete(conn, Routes.role_path(conn, :delete, first_role_id))

      roles = Repo.all(Role)

      assert response(conn, 204)
      assert length(roles) == 1
      assert hd(roles).id == second_role_id
    end

    test "should return a error if no role is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()
      conn = delete(conn, Routes.role_path(conn, :delete, unregistered_id))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
