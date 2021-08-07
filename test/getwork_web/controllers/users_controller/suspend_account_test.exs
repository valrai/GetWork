defmodule GetworkWeb.UserController.SuspendAccountTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Users.User

  describe "suspend_account" do
    setup %{conn: conn} do
      insert!(:user)
      insert!(:user)
      us = insert!(:user)

      {:ok, conn: conn, user_id: us.id}
    end

    test "should suspend_account the correct user.", %{conn: conn, user_id: user_id} do
      put(conn, Routes.user_path(conn, :suspend_account, user_id))

      [suspended_user_account] =
        User
        |> where(is_active: false)
        |> Repo.all()

      assert suspended_user_account.id == user_id
    end

    test "should set the suspended account as inactive.", %{conn: conn, user_id: id} do
      conn = put(conn, Routes.user_path(conn, :suspend_account, id))

      response_data = json_response(conn, 200)["data"]

      refute response_data["is_active"]
    end

    test ~s(should set the "suspension_end_date" field with the current date.), %{
      conn: conn,
      user_id: id
    } do
      conn = put(conn, Routes.user_path(conn, :suspend_account, id))

      response_data = json_response(conn, 200)["data"]
      today = Date.utc_today() |> Date.to_iso8601()

      assert response_data["suspension_end_date"] == today
    end

    test "should return a error if no user is found for the given id.", %{conn: conn} do
      conn = put(conn, Routes.user_path(conn, :suspend_account, Ecto.UUID.generate()))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
