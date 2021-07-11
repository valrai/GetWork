defmodule Getwork.Skills.CreateTest do
  use Getwork.DataCase, async: true

  alias Getwork.Skills
  alias Getwork.Skills.Skill

  describe "create_skill" do
    test "should create a new skill." do
      {:ok, %Skill{id: id, name: name}} = Skills.create_skill(%{"name" => "valid name"})

      refute is_nil(id)
      assert name == "valid name"
    end

    test "should return a error if any parameter fails in the validations." do
      result = Skills.create_skill(%{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end
  end
end
