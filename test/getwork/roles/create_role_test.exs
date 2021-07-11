defmodule Getwork.Roles.CreateTest do
  use Getwork.DataCase, async: true

  alias Getwork.Roles
  alias Getwork.Roles.Role

  describe "create_role" do
    test "should create a new role." do
      {:ok, %Role{id: id, name: name}} = Roles.create_role(%{"name" => "valid name"})

      refute is_nil(id)
      assert name == "valid name"
    end

    test "should return a error if any parameter fails in the validations." do
      result = Roles.create_role(%{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end
  end
end
