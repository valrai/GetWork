defmodule GetworkWeb.UserController.ListTest do
  use GetworkWeb.ConnCase, async: true
  import Getwork.Factory

  @email "test@email.com"
  @username "test_username"

  describe "list" do
    test "should list all registered users when no filter is defined.", %{conn: conn} do
      create_users()
      conn = get(conn, Routes.user_path(conn, :index))
      response_data = json_response(conn, 200)["data"]

      assert length(response_data) == 3
    end

    test "should return a empty list if no user is found.", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      response_data = json_response(conn, 200)["data"]

      assert response_data == []
    end

    test "should allow filter only the active users.", %{conn: conn} do
      create_users()
      conn = get(conn, Routes.user_path(conn, :index), %{"is_active" => true})
      response_data = json_response(conn, 200)["data"]

      assert Enum.all?(response_data, & &1["is_active"])
    end

    test "should allow filter only the not active users.", %{conn: conn} do
      create_users()
      conn = get(conn, Routes.user_path(conn, :index), %{"is_active" => false})
      response_data = json_response(conn, 200)["data"]

      assert Enum.all?(response_data, &(not &1["is_active"]))
    end

    test "should allow filter the users by email.", %{conn: conn} do
      create_users()
      conn = get(conn, Routes.user_path(conn, :index), %{"email" => @email})
      response_data = json_response(conn, 200)["data"]

      assert Enum.all?(response_data, &(&1["email"] == @email))
    end

    test "should allow filter the users by username.", %{conn: conn} do
      create_users()
      conn = get(conn, Routes.user_path(conn, :index), %{"username" => @username})
      response_data = json_response(conn, 200)["data"]

      assert Enum.all?(response_data, &(&1["username"] == @username))
    end
  end

  defp create_users do
    insert!(:user, email: @email)
    insert!(:user, is_active: false)
    insert!(:user, username: @username)
  end
end
