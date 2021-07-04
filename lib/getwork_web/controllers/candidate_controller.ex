defmodule GetworkWeb.CandidateController do
  use GetworkWeb, :controller

  alias Getwork.Candidates
  alias Getwork.Candidates.Candidate

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    candidates = Candidates.list_candidates()
    render(conn, "index.json", candidates: candidates)
  end

  def create(conn, %{"candidate" => candidate_params}) do
    with {:ok, %Candidate{} = candidate} <- Candidates.create_candidate(candidate_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.candidate_path(conn, :show, candidate))
      |> render("show.json", candidate: candidate)
    end
  end

  def show(conn, %{"id" => id}) do
    candidate = Candidates.get_candidate!(id)
    render(conn, "show.json", candidate: candidate)
  end

  def update(conn, %{"id" => id, "candidate" => candidate_params}) do
    candidate = Candidates.get_candidate!(id)

    with {:ok, %Candidate{} = candidate} <-
           Candidates.update_candidate(candidate, candidate_params) do
      render(conn, "show.json", candidate: candidate)
    end
  end

  def delete(conn, %{"id" => id}) do
    candidate = Candidates.get_candidate!(id)

    with {:ok, %Candidate{}} <- Candidates.delete_candidate(candidate) do
      send_resp(conn, :no_content, "")
    end
  end
end
