defmodule GetworkWeb.ClaimController do
  use GetworkWeb, :controller

  alias Getwork.Claims
  alias Getwork.Claims.Claim

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    {:ok, claims} = Claims.list_claims()
    render(conn, "index.json", claims: claims)
  end

  def create(conn, claim_params) do
    with {:ok, %Claim{} = claim} <- Claims.create_claim(claim_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.claim_path(conn, :show, claim))
      |> render("show.json", claim: claim)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, claim} <- Claims.get_claim(id) do
      render(conn, "show.json", claim: claim)
    end
  end

  def update(conn, claim_params) do
    with {:ok, %Claim{} = claim} <- Claims.update_claim(claim_params) do
      render(conn, "show.json", claim: claim)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Claim{}} <- Claims.delete_claim(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
