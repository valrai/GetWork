defmodule GetworkWeb.ClaimView do
  use GetworkWeb, :view
  alias GetworkWeb.ClaimView

  def render("index.json", %{claims: claims}) do
    %{data: render_many(claims, ClaimView, "claim.json")}
  end

  def render("show.json", %{claim: claim}) do
    %{data: render_one(claim, ClaimView, "claim.json")}
  end

  def render("claim.json", %{claim: claim}) do
    %{
      id: claim.id,
      name: claim.name
    }
  end
end
