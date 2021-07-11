defmodule GetworkWeb.SkillController do
  use GetworkWeb, :controller

  alias Getwork.Skills
  alias Getwork.Skills.Skill

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    with {:ok, skills} <- Skills.list_skills() do
      render(conn, "index.json", skills: skills)
    end
  end

  def create(conn, skill_params) do
    with {:ok, %Skill{} = skill} <- Skills.create_skill(skill_params) do
      conn
      |> put_status(:created)
      |> render("show.json", skill: skill)
    end
  end

  def update(conn, skill_params) do
    with {:ok, %Skill{} = skill} <- Skills.update_skill(skill_params["id"], skill_params) do
      render(conn, "show.json", skill: skill)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Skill{}} <- Skills.delete_skill(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
