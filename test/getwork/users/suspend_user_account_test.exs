defmodule Getwork.Users.SuspendUserAccountTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Users
  alias Getwork.Users.User

  describe "suspend_user_account" do
    setup do
      insert!(:user)
      insert!(:user)
      us = insert!(:user)

      {:ok, user_id: us.id}
    end

    test "should suspend the correct user account.", %{user_id: id} do
      Users.suspend_user_account(id)

      [suspended_user_account] =
        User
        |> where(is_active: false)
        |> Repo.all()

      assert suspended_user_account.id == id
    end

    test "should set the suspended account as inactive.", %{user_id: id} do
      {:ok, suspended_user_account} = Users.suspend_user_account(id)

      refute suspended_user_account.is_active
    end

    test ~s(should set the "suspension_end_date" field with the current date.), %{user_id: id} do
      {:ok, %{suspension_end_date: suspension_end_date}} = Users.suspend_user_account(id)

      assert suspension_end_date == Date.utc_today()
    end

    test "should return a error if no user is found for the given id." do
      result = Ecto.UUID.generate() |> Users.suspend_user_account()

      assert match?({:error, 404, _}, result)
    end
  end
end
