defmodule Getwork.Roles.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Roles
  alias Getwork.Roles.Role

  describe "update_role" do
    setup do
      insert!(:role)
      insert!(:role)
      rl = insert!(:role)

      {:ok, role_id: rl.id}
    end

    test "should update the correct role.", %{role_id: id} do
      Roles.update_role(id, %{"name" => "new name"})

      updated_roles =
        Role
        |> where(name: "new name")
        |> Repo.all()

      assert length(updated_roles) == 1
      assert hd(updated_roles).id == id
      assert hd(updated_roles).name == "new name"
    end

    test "should return a error if any parameter fails in the validations.", %{
      role_id: id
    } do
      result = Roles.update_role(id, %{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should return a error if no role is found for the given id." do
      result = Ecto.UUID.generate() |> Roles.update_role(%{"name" => "new name"})

      assert match?({:error, 404, _}, result)
    end
  end
end
