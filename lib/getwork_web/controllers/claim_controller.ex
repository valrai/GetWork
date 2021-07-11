defmodule GetworkWeb.ClaimController do
  use GetworkWeb, :controller

  alias Getwork.Claims
  alias Getwork.Claims.Claim

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    with {:ok, claims} <- Claims.list_claims() do
      render(conn, "index.json", claims: claims)
    end
  end

  def create(conn, claim_params) do
    with {:ok, %Claim{} = claim} <- Claims.create_claim(claim_params) do
      conn
      |> put_status(:created)
      |> render("show.json", claim: claim)
    end
  end

  def update(conn, claim_params) do
    with {:ok, %Claim{} = claim} <- Claims.update_claim(claim_params["id"], claim_params) do
      render(conn, "show.json", claim: claim)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Claim{}} <- Claims.delete_claim(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
