defmodule GetworkWeb.JobOfferControllerTest do
  use GetworkWeb.ConnCase

  alias Getwork.JobOffers
  alias Getwork.JobOffers.JobOffer

  @create_attrs %{
    description: "some description",
    end_date: ~D[2010-04-17],
    is_filled: true,
    number_of_positions: 42,
    start_date: ~D[2010-04-17],
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    end_date: ~D[2011-05-18],
    is_filled: false,
    number_of_positions: 43,
    start_date: ~D[2011-05-18],
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, end_date: nil, is_filled: nil, number_of_positions: nil, start_date: nil, title: nil}

  def fixture(:job_offer) do
    {:ok, job_offer} = JobOffers.create_job_offer(@create_attrs)
    job_offer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all job_offers", %{conn: conn} do
      conn = get(conn, Routes.job_offer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create job_offer" do
    test "renders job_offer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.job_offer_path(conn, :create), job_offer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.job_offer_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "end_date" => "2010-04-17",
               "is_filled" => true,
               "number_of_positions" => 42,
               "start_date" => "2010-04-17",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.job_offer_path(conn, :create), job_offer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update job_offer" do
    setup [:create_job_offer]

    test "renders job_offer when data is valid", %{conn: conn, job_offer: %JobOffer{id: id} = job_offer} do
      conn = put(conn, Routes.job_offer_path(conn, :update, job_offer), job_offer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.job_offer_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "end_date" => "2011-05-18",
               "is_filled" => false,
               "number_of_positions" => 43,
               "start_date" => "2011-05-18",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, job_offer: job_offer} do
      conn = put(conn, Routes.job_offer_path(conn, :update, job_offer), job_offer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete job_offer" do
    setup [:create_job_offer]

    test "deletes chosen job_offer", %{conn: conn, job_offer: job_offer} do
      conn = delete(conn, Routes.job_offer_path(conn, :delete, job_offer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.job_offer_path(conn, :show, job_offer))
      end
    end
  end

  defp create_job_offer(_) do
    job_offer = fixture(:job_offer)
    %{job_offer: job_offer}
  end
end
