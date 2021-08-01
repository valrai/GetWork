defmodule GetworkWeb.UserController.CreateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Bcrypt, only: [verify_pass: 2]

  alias Getwork.Users.User
  alias Getwork.Repo

  describe "create_user" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "should create a new user.", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), get_params())

      response_data = json_response(conn, 201)["data"]

      refute is_nil(response_data["id"])
    end

    test "should allow save the roles of the user.", %{conn: conn} do
      params = get_params(roles: get_roles())
      conn = post(conn, Routes.user_path(conn, :create), params)

      response_data = json_response(conn, 201)["data"]

      refute Enum.empty?(response_data["roles"])
    end

    test "should return a error if any parameter fails in the validations.", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), get_params(email: "invalid email"))

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should save the correct user encoded password.", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), get_params(password: "12345678"))

      response_data = json_response(conn, 201)["data"]
      %{password_hash: password_hash} = Repo.get(User, response_data["id"])

      assert verify_pass("12345678", password_hash)
    end

    test "should not return the decrypted user password.", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), get_params(password: "12345678"))

      response_data = json_response(conn, 201)["data"]

      assert is_nil(response_data["password"])
    end

    test ~s(should set the user as "active" by default.), %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), get_params())

      response_data = json_response(conn, 201)["data"]

      assert response_data["is_active"]
    end
  end

  defp get_roles() do
    %{id: first_id} = insert!(:role)
    %{id: second_id} = insert!(:role)

    [first_id, second_id]
  end

  defp get_params(attrs \\ []) do
    user = build(:user, attrs)

    %{
      "username" => user.username,
      "email" => user.email,
      "password" => user.password,
      "roles" => user.roles
    }
  end
end
