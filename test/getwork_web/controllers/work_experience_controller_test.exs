defmodule GetworkWeb.WorkExperienceControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.WorkExperiences
  alias Getwork.WorkExperiences.WorkExperience

  @create_attrs %{
    company_or_project: "some company_or_project",
    current_job: "some current_job",
    description: "some description",
    end_date: ~D[2010-04-17],
    job_position: "some job_position",
    start_date: ~D[2010-04-17],
    type: "some type"
  }
  @update_attrs %{
    company_or_project: "some updated company_or_project",
    current_job: "some updated current_job",
    description: "some updated description",
    end_date: ~D[2011-05-18],
    job_position: "some updated job_position",
    start_date: ~D[2011-05-18],
    type: "some updated type"
  }
  @invalid_attrs %{company_or_project: nil, current_job: nil, description: nil, end_date: nil, job_position: nil, start_date: nil, type: nil}

  def fixture(:work_experience) do
    {:ok, work_experience} = WorkExperiences.create_work_experience(@create_attrs)
    work_experience
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all work_experiences", %{conn: conn} do
      conn = get(conn, Routes.work_experience_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create work_experience" do
    test "renders work_experience when data is valid", %{conn: conn} do
      conn = post(conn, Routes.work_experience_path(conn, :create), work_experience: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.work_experience_path(conn, :show, id))

      assert %{
               "id" => id,
               "company_or_project" => "some company_or_project",
               "current_job" => "some current_job",
               "description" => "some description",
               "end_date" => "2010-04-17",
               "job_position" => "some job_position",
               "start_date" => "2010-04-17",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.work_experience_path(conn, :create), work_experience: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update work_experience" do
    setup [:create_work_experience]

    test "renders work_experience when data is valid", %{conn: conn, work_experience: %WorkExperience{id: id} = work_experience} do
      conn = put(conn, Routes.work_experience_path(conn, :update, work_experience), work_experience: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.work_experience_path(conn, :show, id))

      assert %{
               "id" => id,
               "company_or_project" => "some updated company_or_project",
               "current_job" => "some updated current_job",
               "description" => "some updated description",
               "end_date" => "2011-05-18",
               "job_position" => "some updated job_position",
               "start_date" => "2011-05-18",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, work_experience: work_experience} do
      conn = put(conn, Routes.work_experience_path(conn, :update, work_experience), work_experience: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete work_experience" do
    setup [:create_work_experience]

    test "deletes chosen work_experience", %{conn: conn, work_experience: work_experience} do
      conn = delete(conn, Routes.work_experience_path(conn, :delete, work_experience))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.work_experience_path(conn, :show, work_experience))
      end
    end
  end

  defp create_work_experience(_) do
    work_experience = fixture(:work_experience)
    %{work_experience: work_experience}
  end
end
