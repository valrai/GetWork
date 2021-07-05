defmodule GetworkWeb.WorkExperienceController do
  use GetworkWeb, :controller

  alias Getwork.WorkExperiences
  alias Getwork.WorkExperiences.WorkExperience

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    work_experiences = WorkExperiences.list_work_experiences()
    render(conn, "index.json", work_experiences: work_experiences)
  end

  def create(conn, %{"work_experience" => work_experience_params}) do
    with {:ok, %WorkExperience{} = work_experience} <-
           WorkExperiences.create_work_experience(work_experience_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.work_experience_path(conn, :show, work_experience))
      |> render("show.json", work_experience: work_experience)
    end
  end

  def show(conn, %{"id" => id}) do
    work_experience = WorkExperiences.get_work_experience!(id)
    render(conn, "show.json", work_experience: work_experience)
  end

  def update(conn, %{"id" => id, "work_experience" => work_experience_params}) do
    work_experience = WorkExperiences.get_work_experience!(id)

    with {:ok, %WorkExperience{} = work_experience} <-
           WorkExperiences.update_work_experience(work_experience, work_experience_params) do
      render(conn, "show.json", work_experience: work_experience)
    end
  end

  def delete(conn, %{"id" => id}) do
    work_experience = WorkExperiences.get_work_experience!(id)

    with {:ok, %WorkExperience{}} <- WorkExperiences.delete_work_experience(work_experience) do
      send_resp(conn, :no_content, "")
    end
  end
end
