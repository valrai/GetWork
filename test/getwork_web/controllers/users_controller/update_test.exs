defmodule GetworkWeb.UserController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Users.User

  describe "update" do
    setup %{conn: conn} do
      insert!(:user)
      insert!(:user)

      first_role = insert!(:role)
      second_role = insert!(:role)

      us = insert!(:user, roles: [first_role, second_role])

      {:ok, conn: conn, user_id: us.id}
    end

    test "should update the correct user.", %{conn: conn, user_id: user_id} do
      put(conn, Routes.user_path(conn, :update, user_id), %{"username" => "new username"})

      [updated_user] =
        User
        |> where(username: "new username")
        |> Repo.all()

      assert updated_user.id == user_id
      assert updated_user.username == "new username"
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      user_id: user_id
    } do
      conn = put(conn, Routes.user_path(conn, :update, user_id), %{"email" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should allow update the roles of the user.", %{conn: conn, user_id: user_id} do
      new_role = insert!(:role)

      conn = put(conn, Routes.user_path(conn, :update, user_id), %{"roles" => [new_role.id]})
      [role] = json_response(conn, 200)["data"]["roles"]

      assert role["name"] == new_role.name
    end

    test "should not return the decrypted user password.", %{conn: conn, user_id: user_id} do
      conn = put(conn, Routes.user_path(conn, :update, user_id), %{"username" => "new username"})
      response_data = json_response(conn, 200)["data"]

      assert is_nil(response_data["password"])
    end

    test ~s(should not allow update the "is_active" field), %{conn: conn, user_id: user_id} do
      conn = put(conn, Routes.user_path(conn, :update, user_id), %{"is_active" => false})
      response_data = json_response(conn, 200)["data"]

      assert response_data["is_active"]
    end

    test ~s(should not allow update the "suspension_end_date" field), %{
      conn: conn,
      user_id: user_id
    } do
      conn =
        put(conn, Routes.user_path(conn, :update, user_id), %{
          "suspension_end_date" => ~N[2019-10-31 23:00:07]
        })

      response_data = json_response(conn, 200)["data"]

      assert is_nil(response_data["suspension_end_date"])
    end

    test "should return a error if no user is found for the given id.", %{conn: conn} do
      conn =
        put(conn, Routes.user_path(conn, :update, Ecto.UUID.generate()), %{
          "username" => "new username"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
