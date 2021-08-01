defmodule Getwork.Users.CreateUserTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Bcrypt, only: [verify_pass: 2]

  alias Getwork.Users
  alias Getwork.Users.User

  describe "create_user" do
    test "should create a new user." do
      {:ok, %User{id: id}} = create_user()

      refute is_nil(id)
    end

    test "should allow save the roles of the user." do
      %{id: first_role_id} = insert!(:role)
      %{id: second_role_id} = insert!(:role)

      {:ok, %User{roles: roles}} = create_user(roles: [first_role_id, second_role_id])

      refute Enum.empty?(roles)
    end

    test "should return a error if any parameter fails in the validations." do
      result = create_user(email: "invalid email")

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should save the correct user encoded password." do
      {:ok, %User{} = user} = create_user(password: "12345678")

      assert verify_pass("12345678", user.password_hash)
    end

    test "should not return the decrypted user password." do
      {:ok, %User{password: password}} = create_user()

      assert is_nil(password)
    end

    test ~s(should set the user as "active" by default.) do
      {:ok, %User{is_active: is_active?}} = create_user()

      assert is_active?
    end
  end

  defp create_user(attrs \\ []) do
    user = build(:user, attrs)

    %{
      "username" => user.username,
      "email" => user.email,
      "password" => user.password,
      "roles" => user.roles
    }
    |> Users.create_user()
  end
end
