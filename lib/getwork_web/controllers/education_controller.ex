defmodule GetworkWeb.EducationController do
  use GetworkWeb, :controller

  alias Getwork.Qualifications
  alias Getwork.Qualifications.Education

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    qualifications = Qualifications.list_qualifications()
    render(conn, "index.json", qualifications: qualifications)
  end

  def create(conn, %{"education" => education_params}) do
    with {:ok, %Education{} = education} <- Qualifications.create_education(education_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.education_path(conn, :show, education))
      |> render("show.json", education: education)
    end
  end

  def show(conn, %{"id" => id}) do
    education = Qualifications.get_education!(id)
    render(conn, "show.json", education: education)
  end

  def update(conn, %{"id" => id, "education" => education_params}) do
    education = Qualifications.get_education!(id)

    with {:ok, %Education{} = education} <-
           Qualifications.update_education(education, education_params) do
      render(conn, "show.json", education: education)
    end
  end

  def delete(conn, %{"id" => id}) do
    education = Qualifications.get_education!(id)

    with {:ok, %Education{}} <- Qualifications.delete_education(education) do
      send_resp(conn, :no_content, "")
    end
  end
end
