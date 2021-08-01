defmodule Getwork.Users.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Users
  alias Getwork.Users.User
  alias Getwork.Candidates.Candidate
  alias Getwork.Companies.Company

  describe "delete_user" do
    test "should remove the correct user." do
      %{id: first_user_id} = insert!(:user)
      %{id: second_user_id} = insert!(:user)

      Users.delete_user(first_user_id)
      users = Repo.all(User)

      assert match?([%User{}], users)
      assert hd(users).id == second_user_id
    end

    test "should return a error if no user is found for the given name." do
      result = Ecto.UUID.generate() |> Users.delete_user()

      assert match?({:error, 404, _}, result)
    end

    test ~s(should delete the associations with the "roles" table) do
      first_role = insert!(:role)
      second_role = insert!(:role)
      %{id: first_user_id} = insert!(:user, roles: [first_role])
      %{id: second_user_id} = insert!(:user, roles: [first_role, second_role])

      Users.delete_user(second_user_id)

      user_roles =
        from(ur in "user_roles")
        |> select([ur], %{user_id: ur.user_id, role_id: ur.role_id})
        |> Repo.all()

      associated_user_id =
        user_roles
        |> hd()
        |> Map.get(:user_id)
        |> Ecto.UUID.cast!()

      assert length(user_roles) == 1
      assert associated_user_id == first_user_id
    end

    test ~s(should delete the associations with the "candidates" table) do
      %{id: first_user_id} = insert!(:user)
      %{id: second_user_id} = insert!(:user)
      insert!(:candidate, user_id: first_user_id)
      insert!(:candidate, user_id: second_user_id)

      Users.delete_user(second_user_id)
      candidates = Repo.all(Candidate)

      assert length(candidates) == 1
      assert hd(candidates).user_id == first_user_id
    end

    test ~s(should delete the associations with the "companies" table) do
      %{id: first_user_id} = insert!(:user)
      %{id: second_user_id} = insert!(:user)
      insert!(:company, user_id: first_user_id)
      insert!(:company, user_id: second_user_id)

      Users.delete_user(second_user_id)
      companies = Repo.all(Company)

      assert length(companies) == 1
      assert hd(companies).user_id == first_user_id
    end
  end
end
