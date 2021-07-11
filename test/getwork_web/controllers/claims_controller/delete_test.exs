defmodule GetworkWeb.ClaimController.DeleteTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Claims.Claim

  describe "delete_claim" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should remove the correct claim.", %{conn: conn} do
      %{id: first_claim_id} = insert!(:claim)
      %{id: second_claim_id} = insert!(:claim)

      conn = delete(conn, Routes.claim_path(conn, :delete, first_claim_id))

      claims = Repo.all(Claim)

      assert response(conn, 204)
      assert length(claims) == 1
      assert hd(claims).id == second_claim_id
    end

    test "should return a error if no claim is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()
      conn = delete(conn, Routes.claim_path(conn, :delete, unregistered_id))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
