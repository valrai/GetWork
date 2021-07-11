defmodule GetworkWeb.SkillController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Skills.Skill

  describe "update_skill" do
    setup %{conn: conn} do
      insert!(:skill)
      insert!(:skill)
      la = insert!(:skill)

      {:ok, conn: put_req_header(conn, "accept", "application/json"), skill_id: la.id}
    end

    test "should update the correct skill.", %{conn: conn, skill_id: id} do
      skill = %{"name" => "new name"}
      put(conn, Routes.skill_path(conn, :update, id), skill)

      updated_skills =
        Skill
        |> where(name: ^skill["name"])
        |> Repo.all()

      assert length(updated_skills) == 1
      assert hd(updated_skills).name == skill["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      skill_id: id
    } do
      conn = put(conn, Routes.skill_path(conn, :update, id), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should return a error if no skill is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()

      conn =
        put(conn, Routes.skill_path(conn, :update, unregistered_id), %{
          "name" => "new name"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
