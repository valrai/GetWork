defmodule Getwork.CandidatesTest do
  use Getwork.DataCase

  alias Getwork.Candidates

  describe "candidates" do
    alias Getwork.Candidates.Candidate

    @valid_attrs %{last_name: "some last_name", link: "some link", name: "some name", nin: "some nin", picture_url: "some picture_url"}
    @update_attrs %{last_name: "some updated last_name", link: "some updated link", name: "some updated name", nin: "some updated nin", picture_url: "some updated picture_url"}
    @invalid_attrs %{last_name: nil, link: nil, name: nil, nin: nil, picture_url: nil}

    def candidate_fixture(attrs \\ %{}) do
      {:ok, candidate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Candidates.create_candidate()

      candidate
    end

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Candidates.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Candidates.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      assert {:ok, %Candidate{} = candidate} = Candidates.create_candidate(@valid_attrs)
      assert candidate.last_name == "some last_name"
      assert candidate.link == "some link"
      assert candidate.name == "some name"
      assert candidate.nin == "some nin"
      assert candidate.picture_url == "some picture_url"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Candidates.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{} = candidate} = Candidates.update_candidate(candidate, @update_attrs)
      assert candidate.last_name == "some updated last_name"
      assert candidate.link == "some updated link"
      assert candidate.name == "some updated name"
      assert candidate.nin == "some updated nin"
      assert candidate.picture_url == "some updated picture_url"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Candidates.update_candidate(candidate, @invalid_attrs)
      assert candidate == Candidates.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Candidates.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Candidates.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Candidates.change_candidate(candidate)
    end
  end
end
