defmodule GetworkWeb.JobOfferView do
  use GetworkWeb, :view
  alias GetworkWeb.JobOfferView

  def render("index.json", %{job_offers: job_offers}) do
    %{data: render_many(job_offers, JobOfferView, "job_offer.json")}
  end

  def render("show.json", %{job_offer: job_offer}) do
    %{data: render_one(job_offer, JobOfferView, "job_offer.json")}
  end

  def render("job_offer.json", %{job_offer: job_offer}) do
    %{id: job_offer.id,
      title: job_offer.title,
      description: job_offer.description,
      number_of_positions: job_offer.number_of_positions,
      start_date: job_offer.start_date,
      end_date: job_offer.end_date,
      is_filled: job_offer.is_filled}
  end
end
