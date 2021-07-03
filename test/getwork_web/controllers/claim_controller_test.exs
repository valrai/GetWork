defmodule GetworkWeb.ClaimControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.Claims
  alias Getwork.Claims.Claim

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:claim) do
    {:ok, claim} = Claims.create_claim(@create_attrs)
    claim
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all claims", %{conn: conn} do
      conn = get(conn, Routes.claim_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create claim" do
    test "renders claim when data is valid", %{conn: conn} do
      conn = post(conn, Routes.claim_path(conn, :create), claim: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.claim_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.claim_path(conn, :create), claim: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update claim" do
    setup [:create_claim]

    test "renders claim when data is valid", %{conn: conn, claim: %Claim{id: id} = claim} do
      conn = put(conn, Routes.claim_path(conn, :update, claim), claim: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.claim_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, claim: claim} do
      conn = put(conn, Routes.claim_path(conn, :update, claim), claim: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete claim" do
    setup [:create_claim]

    test "deletes chosen claim", %{conn: conn, claim: claim} do
      conn = delete(conn, Routes.claim_path(conn, :delete, claim))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.claim_path(conn, :show, claim))
      end
    end
  end

  defp create_claim(_) do
    claim = fixture(:claim)
    %{claim: claim}
  end
end
