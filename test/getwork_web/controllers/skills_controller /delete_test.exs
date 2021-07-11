defmodule GetworkWeb.SkillController.DeleteTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Skills.Skill

  describe "delete_skill" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should remove the correct skill.", %{conn: conn} do
      %{id: first_skill_id} = insert!(:skill)
      %{id: second_skill_id} = insert!(:skill)

      conn = delete(conn, Routes.skill_path(conn, :delete, first_skill_id))

      skills = Repo.all(Skill)

      assert response(conn, 204)
      assert length(skills) == 1
      assert hd(skills).id == second_skill_id
    end

    test "should return a error if no skill is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()
      conn = delete(conn, Routes.skill_path(conn, :delete, unregistered_id))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
