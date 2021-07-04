defmodule GetworkWeb.CandidateView do
  use GetworkWeb, :view
  alias GetworkWeb.CandidateView

  def render("index.json", %{candidates: candidates}) do
    %{data: render_many(candidates, CandidateView, "candidate.json")}
  end

  def render("show.json", %{candidate: candidate}) do
    %{data: render_one(candidate, CandidateView, "candidate.json")}
  end

  def render("candidate.json", %{candidate: candidate}) do
    %{id: candidate.id,
      nin: candidate.nin,
      name: candidate.name,
      last_name: candidate.last_name,
      link: candidate.link,
      picture_url: candidate.picture_url}
  end
end
