defmodule GetworkWeb.CandidateControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.Candidates
  alias Getwork.Candidates.Candidate

  @create_attrs %{
    last_name: "some last_name",
    link: "some link",
    name: "some name",
    nin: "some nin",
    picture_url: "some picture_url"
  }
  @update_attrs %{
    last_name: "some updated last_name",
    link: "some updated link",
    name: "some updated name",
    nin: "some updated nin",
    picture_url: "some updated picture_url"
  }
  @invalid_attrs %{last_name: nil, link: nil, name: nil, nin: nil, picture_url: nil}

  def fixture(:candidate) do
    {:ok, candidate} = Candidates.create_candidate(@create_attrs)
    candidate
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all candidates", %{conn: conn} do
      conn = get(conn, Routes.candidate_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create candidate" do
    test "renders candidate when data is valid", %{conn: conn} do
      conn = post(conn, Routes.candidate_path(conn, :create), candidate: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.candidate_path(conn, :show, id))

      assert %{
               "id" => id,
               "last_name" => "some last_name",
               "link" => "some link",
               "name" => "some name",
               "nin" => "some nin",
               "picture_url" => "some picture_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.candidate_path(conn, :create), candidate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update candidate" do
    setup [:create_candidate]

    test "renders candidate when data is valid", %{conn: conn, candidate: %Candidate{id: id} = candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.candidate_path(conn, :show, id))

      assert %{
               "id" => id,
               "last_name" => "some updated last_name",
               "link" => "some updated link",
               "name" => "some updated name",
               "nin" => "some updated nin",
               "picture_url" => "some updated picture_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, candidate: candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete candidate" do
    setup [:create_candidate]

    test "deletes chosen candidate", %{conn: conn, candidate: candidate} do
      conn = delete(conn, Routes.candidate_path(conn, :delete, candidate))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.candidate_path(conn, :show, candidate))
      end
    end
  end

  defp create_candidate(_) do
    candidate = fixture(:candidate)
    %{candidate: candidate}
  end
end
