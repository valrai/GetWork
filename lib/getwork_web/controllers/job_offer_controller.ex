defmodule GetworkWeb.JobOfferController do
  use GetworkWeb, :controller

  alias Getwork.JobOffers
  alias Getwork.JobOffers.JobOffer

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    job_offers = JobOffers.list_job_offers()
    render(conn, "index.json", job_offers: job_offers)
  end

  def create(conn, %{"job_offer" => job_offer_params}) do
    with {:ok, %JobOffer{} = job_offer} <- JobOffers.create_job_offer(job_offer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.job_offer_path(conn, :show, job_offer))
      |> render("show.json", job_offer: job_offer)
    end
  end

  def show(conn, %{"id" => id}) do
    job_offer = JobOffers.get_job_offer!(id)
    render(conn, "show.json", job_offer: job_offer)
  end

  def update(conn, %{"id" => id, "job_offer" => job_offer_params}) do
    job_offer = JobOffers.get_job_offer!(id)

    with {:ok, %JobOffer{} = job_offer} <- JobOffers.update_job_offer(job_offer, job_offer_params) do
      render(conn, "show.json", job_offer: job_offer)
    end
  end

  def delete(conn, %{"id" => id}) do
    job_offer = JobOffers.get_job_offer!(id)

    with {:ok, %JobOffer{}} <- JobOffers.delete_job_offer(job_offer) do
      send_resp(conn, :no_content, "")
    end
  end
end
