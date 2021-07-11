defmodule Getwork.Skills.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Skills
  alias Getwork.Skills.Skill

  describe "update_skill" do
    setup do
      insert!(:skill)
      insert!(:skill)
      la = insert!(:skill)

      {:ok, skill_id: la.id}
    end

    test "should update the correct skill.", %{skill_id: id} do
      Skills.update_skill(id, %{"name" => "new name"})

      updated_skills =
        Skill
        |> where(name: "new name")
        |> Repo.all()

      assert length(updated_skills) == 1
      assert hd(updated_skills).id == id
      assert hd(updated_skills).name == "new name"
    end

    test "should return a error if any parameter fails in the validations.", %{
      skill_id: id
    } do
      result = Skills.update_skill(id, %{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should return a error if no skill is found for the given name." do
      result = Ecto.UUID.generate() |> Skills.update_skill(%{"name" => "new name"})

      assert match?({:error, 404, _}, result)
    end
  end
end
