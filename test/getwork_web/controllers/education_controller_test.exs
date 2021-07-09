defmodule GetworkWeb.EducationControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.Qualifications
  alias Getwork.Qualifications.Education

  @create_attrs %{
    city: "some city",
    end_date: ~D[2010-04-17],
    institution: "some institution",
    its_currently_attending: true,
    start_date: ~D[2010-04-17],
    type: "some type"
  }
  @update_attrs %{
    city: "some updated city",
    end_date: ~D[2011-05-18],
    institution: "some updated institution",
    its_currently_attending: false,
    start_date: ~D[2011-05-18],
    type: "some updated type"
  }
  @invalid_attrs %{
    city: nil,
    end_date: nil,
    institution: nil,
    its_currently_attending: nil,
    start_date: nil,
    type: nil
  }

  def fixture(:education) do
    {:ok, education} = Qualifications.create_education(@create_attrs)
    education
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all qualifications", %{conn: conn} do
      conn = get(conn, Routes.education_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create education" do
    test "renders education when data is valid", %{conn: conn} do
      conn = post(conn, Routes.education_path(conn, :create), education: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.education_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some city",
               "end_date" => "2010-04-17",
               "institution" => "some institution",
               "its_currently_attending" => true,
               "start_date" => "2010-04-17",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.education_path(conn, :create), education: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update education" do
    setup [:create_education]

    test "renders education when data is valid", %{
      conn: conn,
      education: %Education{id: id} = education
    } do
      conn = put(conn, Routes.education_path(conn, :update, education), education: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.education_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "end_date" => "2011-05-18",
               "institution" => "some updated institution",
               "its_currently_attending" => false,
               "start_date" => "2011-05-18",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, education: education} do
      conn = put(conn, Routes.education_path(conn, :update, education), education: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete education" do
    setup [:create_education]

    test "deletes chosen education", %{conn: conn, education: education} do
      conn = delete(conn, Routes.education_path(conn, :delete, education))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.education_path(conn, :show, education))
      end
    end
  end

  defp create_education(_) do
    education = fixture(:education)
    %{education: education}
  end
end
