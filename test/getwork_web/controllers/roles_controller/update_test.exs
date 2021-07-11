defmodule GetworkWeb.RoleController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Roles.Role

  describe "update_role" do
    setup %{conn: conn} do
      insert!(:role)
      insert!(:role)
      la = insert!(:role)

      {:ok, conn: put_req_header(conn, "accept", "application/json"), role_id: la.id}
    end

    test "should update the correct role.", %{conn: conn, role_id: id} do
      role = %{"name" => "new name"}
      put(conn, Routes.role_path(conn, :update, id), role)

      updated_roles =
        Role
        |> where(name: ^role["name"])
        |> Repo.all()

      assert length(updated_roles) == 1
      assert hd(updated_roles).name == role["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      role_id: id
    } do
      conn = put(conn, Routes.role_path(conn, :update, id), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should return a error if no role is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()

      conn =
        put(conn, Routes.role_path(conn, :update, unregistered_id), %{
          "name" => "new name"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
