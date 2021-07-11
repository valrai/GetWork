defmodule GetworkWeb.ClaimController.IndexTest do
  use GetworkWeb.ConnCase, async: true
  import Getwork.Factory

  describe "list_claims" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should list all registered claims.", %{conn: conn} do
      insert!(:claim)
      insert!(:claim)
      insert!(:claim)

      conn = get(conn, Routes.claim_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 3
    end

    test "should return a empty list if no claim is found.", %{conn: conn} do
      conn = get(conn, Routes.claim_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end
end
