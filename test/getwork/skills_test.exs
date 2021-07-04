defmodule Getwork.SkillsTest do
  use Getwork.DataCase

  alias Getwork.Skills

  describe "skill" do
    alias Getwork.Skills.Skill

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def skill_fixture(attrs \\ %{}) do
      {:ok, skill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Skills.create_skill()

      skill
    end

    test "list_skill/0 returns all skill" do
      skill = skill_fixture()
      assert Skills.list_skill() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert Skills.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      assert {:ok, %Skill{} = skill} = Skills.create_skill(@valid_attrs)
      assert skill.name == "some name"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Skills.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{} = skill} = Skills.update_skill(skill, @update_attrs)
      assert skill.name == "some updated name"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Skills.update_skill(skill, @invalid_attrs)
      assert skill == Skills.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = Skills.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> Skills.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = Skills.change_skill(skill)
    end
  end
end
