defmodule Getwork.JobOffersTest do
  use Getwork.DataCase

  alias Getwork.JobOffers

  describe "job_offers" do
    alias Getwork.JobOffers.JobOffer

    @valid_attrs %{description: "some description", end_date: ~D[2010-04-17], is_filled: true, number_of_positions: 42, start_date: ~D[2010-04-17], title: "some title"}
    @update_attrs %{description: "some updated description", end_date: ~D[2011-05-18], is_filled: false, number_of_positions: 43, start_date: ~D[2011-05-18], title: "some updated title"}
    @invalid_attrs %{description: nil, end_date: nil, is_filled: nil, number_of_positions: nil, start_date: nil, title: nil}

    def job_offer_fixture(attrs \\ %{}) do
      {:ok, job_offer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> JobOffers.create_job_offer()

      job_offer
    end

    test "list_job_offers/0 returns all job_offers" do
      job_offer = job_offer_fixture()
      assert JobOffers.list_job_offers() == [job_offer]
    end

    test "get_job_offer!/1 returns the job_offer with given id" do
      job_offer = job_offer_fixture()
      assert JobOffers.get_job_offer!(job_offer.id) == job_offer
    end

    test "create_job_offer/1 with valid data creates a job_offer" do
      assert {:ok, %JobOffer{} = job_offer} = JobOffers.create_job_offer(@valid_attrs)
      assert job_offer.description == "some description"
      assert job_offer.end_date == ~D[2010-04-17]
      assert job_offer.is_filled == true
      assert job_offer.number_of_positions == 42
      assert job_offer.start_date == ~D[2010-04-17]
      assert job_offer.title == "some title"
    end

    test "create_job_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JobOffers.create_job_offer(@invalid_attrs)
    end

    test "update_job_offer/2 with valid data updates the job_offer" do
      job_offer = job_offer_fixture()
      assert {:ok, %JobOffer{} = job_offer} = JobOffers.update_job_offer(job_offer, @update_attrs)
      assert job_offer.description == "some updated description"
      assert job_offer.end_date == ~D[2011-05-18]
      assert job_offer.is_filled == false
      assert job_offer.number_of_positions == 43
      assert job_offer.start_date == ~D[2011-05-18]
      assert job_offer.title == "some updated title"
    end

    test "update_job_offer/2 with invalid data returns error changeset" do
      job_offer = job_offer_fixture()
      assert {:error, %Ecto.Changeset{}} = JobOffers.update_job_offer(job_offer, @invalid_attrs)
      assert job_offer == JobOffers.get_job_offer!(job_offer.id)
    end

    test "delete_job_offer/1 deletes the job_offer" do
      job_offer = job_offer_fixture()
      assert {:ok, %JobOffer{}} = JobOffers.delete_job_offer(job_offer)
      assert_raise Ecto.NoResultsError, fn -> JobOffers.get_job_offer!(job_offer.id) end
    end

    test "change_job_offer/1 returns a job_offer changeset" do
      job_offer = job_offer_fixture()
      assert %Ecto.Changeset{} = JobOffers.change_job_offer(job_offer)
    end
  end
end
