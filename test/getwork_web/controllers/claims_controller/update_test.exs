defmodule GetworkWeb.ClaimController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Claims.Claim

  describe "update_claim" do
    setup %{conn: conn} do
      insert!(:claim)
      insert!(:claim)
      la = insert!(:claim)

      {:ok, conn: put_req_header(conn, "accept", "application/json"), claim_id: la.id}
    end

    test "should update the correct claim.", %{conn: conn, claim_id: id} do
      claim = %{"name" => "new name"}
      put(conn, Routes.claim_path(conn, :update, id), claim)

      updated_claims =
        Claim
        |> where(name: ^claim["name"])
        |> Repo.all()

      assert length(updated_claims) == 1
      assert hd(updated_claims).name == claim["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      claim_id: id
    } do
      conn = put(conn, Routes.claim_path(conn, :update, id), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should return a error if no claim is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()

      conn =
        put(conn, Routes.claim_path(conn, :update, unregistered_id), %{
          "name" => "new name"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
