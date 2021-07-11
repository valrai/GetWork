defmodule Getwork.Skills.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Skills
  alias Getwork.Skills.Skill

  describe "delete_skill" do
    test "should remove the correct skill." do
      %{id: first_skill_id} = insert!(:skill)
      %{id: second_skill_id} = insert!(:skill)

      Skills.delete_skill(first_skill_id)
      skills = Repo.all(Skill)

      assert match?([%Skill{}], skills)
      assert hd(skills).id == second_skill_id
    end

    test "should return a error if no skill is found for the given name." do
      result = Ecto.UUID.generate() |> Skills.delete_skill()

      assert match?({:error, 404, _}, result)
    end
  end
end
