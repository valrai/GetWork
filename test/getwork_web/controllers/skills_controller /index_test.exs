defmodule GetworkWeb.SkillController.IndexTest do
  use GetworkWeb.ConnCase, async: true
  import Getwork.Factory

  describe "list_skills" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should list all registered skills.", %{conn: conn} do
      insert!(:skill)
      insert!(:skill)
      insert!(:skill)

      conn = get(conn, Routes.skill_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 3
    end

    test "should return a empty list if no skill is found.", %{conn: conn} do
      conn = get(conn, Routes.skill_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end
end
