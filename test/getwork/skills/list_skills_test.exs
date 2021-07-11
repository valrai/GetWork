defmodule Getwork.Skill.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Skills

  describe "list_skills" do
    test "should list all registered skills." do
      insert!(:skill)
      insert!(:skill)
      insert!(:skill)

      {:ok, skills} = Skills.list_skills()

      assert length(skills) == 3
    end

    test "should return a empty list if no skill is found." do
      {:ok, skills} = Skills.list_skills()

      assert skills == []
    end
  end
end
