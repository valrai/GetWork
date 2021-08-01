defmodule Getwork.User.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Users

  @email "test@email.com"
  @username "test_username"

  describe "list_users" do
    test "should list all registered users when no filter is defined." do
      create_users()
      {:ok, users} = Users.list_users()

      assert length(users) == 3
    end

    test "should return a empty list if no user is found." do
      {:ok, users} = Users.list_users()

      assert users == []
    end

    test "should allow filter only the active users." do
      create_users()
      {:ok, users} = Users.list_users(%{"is_active" => true})

      assert Enum.all?(users, & &1.is_active)
    end

    test "should allow filter only the not active users." do
      create_users()
      {:ok, users} = Users.list_users(%{"is_active" => false})

      assert Enum.all?(users, &(not &1.is_active))
    end

    test "should allow filter the users by email." do
      create_users()
      {:ok, users} = Users.list_users(%{"email" => @email})

      assert Enum.all?(users, &(&1.email == @email))
    end

    test "should allow filter the users by username." do
      create_users()
      {:ok, users} = Users.list_users(%{"username" => @username})

      assert Enum.all?(users, &(&1.username == @username))
    end
  end

  defp create_users do
    insert!(:user, email: @email)
    insert!(:user, is_active: false)
    insert!(:user, username: @username)
  end
end
