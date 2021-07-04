defmodule GetworkWeb.SkillController do
  use GetworkWeb, :controller

  alias Getwork.Skills
  alias Getwork.Skills.Skill

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    skill = Skills.list_skill()
    render(conn, "index.json", skill: skill)
  end

  def create(conn, %{"skill" => skill_params}) do
    with {:ok, %Skill{} = skill} <- Skills.create_skill(skill_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.skill_path(conn, :show, skill))
      |> render("show.json", skill: skill)
    end
  end

  def show(conn, %{"id" => id}) do
    skill = Skills.get_skill!(id)
    render(conn, "show.json", skill: skill)
  end

  def update(conn, %{"id" => id, "skill" => skill_params}) do
    skill = Skills.get_skill!(id)

    with {:ok, %Skill{} = skill} <- Skills.update_skill(skill, skill_params) do
      render(conn, "show.json", skill: skill)
    end
  end

  def delete(conn, %{"id" => id}) do
    skill = Skills.get_skill!(id)

    with {:ok, %Skill{}} <- Skills.delete_skill(skill) do
      send_resp(conn, :no_content, "")
    end
  end
end