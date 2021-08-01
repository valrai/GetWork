defmodule Getwork.Users.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Users
  alias Getwork.Users.User

  describe "update_user" do
    setup do
      insert!(:user)
      insert!(:user)
      first_role = insert!(:role)
      second_role = insert!(:role)
      us = insert!(:user, roles: [first_role, second_role])

      {:ok, user_id: us.id}
    end

    test "should update the correct user.", %{user_id: id} do
      Users.update_user(id, %{"username" => "new username"})

      updated_users =
        User
        |> where(username: "new username")
        |> Repo.all()

      assert length(updated_users) == 1
      assert hd(updated_users).id == id
      assert hd(updated_users).username == "new username"
    end

    test "should return a error if any parameter fails in the validations.", %{
      user_id: id
    } do
      result = Users.update_user(id, %{"email" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should allow update the roles of the user.", %{user_id: id} do
      new_role = insert!(:role)

      {:ok, %User{roles: roles}} = Users.update_user(id, %{"roles" => [new_role.id]})

      assert roles == [new_role]
    end

    test "should not return the decrypted user password.", %{user_id: id} do
      {:ok, %User{password: password}} = Users.update_user(id, %{"username" => "new username"})

      assert is_nil(password)
    end

    test ~s(should not allow update the "is_active" field), %{user_id: id} do
      {:ok, %User{is_active: is_active}} = Users.update_user(id, %{"is_active" => false})

      assert is_active
    end

    test ~s(should not allow update the "suspension_end_date" field), %{user_id: id} do
      {:ok, %User{suspension_end_date: suspension_end_date}} =
        Users.update_user(id, %{"suspension_end_date" => ~N[2019-10-31 23:00:07]})

      assert is_nil(suspension_end_date)
    end

    test "should return a error if no user is found for the given id." do
      result = Ecto.UUID.generate() |> Users.update_user(%{"username" => "new username"})

      assert match?({:error, 404, _}, result)
    end
  end
end
