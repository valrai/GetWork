defmodule Getwork.Roles.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Roles

  describe "list_roles" do
    test "should list all registered roles." do
      insert!(:role)
      insert!(:role)
      insert!(:role)

      {:ok, roles} = Roles.list_roles()

      assert length(roles) == 3
    end

    test "should return a empty list if no role is found." do
      {:ok, roles} = Roles.list_roles()

      assert roles == []
    end
  end
end
