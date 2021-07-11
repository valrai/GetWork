defmodule Getwork.Roles.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Roles
  alias Getwork.Roles.Role

  describe "delete_role" do
    test "should remove the correct role." do
      %{id: first_role_id} = insert!(:role)
      %{id: second_role_id} = insert!(:role)

      Roles.delete_role(first_role_id)
      roles = Repo.all(Role)

      assert match?([%Role{}], roles)
      assert hd(roles).id == second_role_id
    end

    test "should return a error if no role is found for the given name." do
      result = Ecto.UUID.generate() |> Roles.delete_role()

      assert match?({:error, 404, _}, result)
    end
  end
end
