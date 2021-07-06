defmodule GetworkWeb.EducationController do
  use GetworkWeb, :controller

  alias Getwork.Educations
  alias Getwork.Educations.Education

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    educations = Educations.list_educations()
    render(conn, "index.json", educations: educations)
  end

  def create(conn, %{"education" => education_params}) do
    with {:ok, %Education{} = education} <- Educations.create_education(education_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.education_path(conn, :show, education))
      |> render("show.json", education: education)
    end
  end

  def show(conn, %{"id" => id}) do
    education = Educations.get_education!(id)
    render(conn, "show.json", education: education)
  end

  def update(conn, %{"id" => id, "education" => education_params}) do
    education = Educations.get_education!(id)

    with {:ok, %Education{} = education} <-
           Educations.update_education(education, education_params) do
      render(conn, "show.json", education: education)
    end
  end

  def delete(conn, %{"id" => id}) do
    education = Educations.get_education!(id)

    with {:ok, %Education{}} <- Educations.delete_education(education) do
      send_resp(conn, :no_content, "")
    end
  end
end
