defmodule Getwork.WorkExperiencesTest do
  use Getwork.DataCase

  alias Getwork.WorkExperiences

  describe "work_experiences" do
    alias Getwork.WorkExperiences.WorkExperience

    @valid_attrs %{company_or_project: "some company_or_project", current_job: "some current_job", description: "some description", end_date: ~D[2010-04-17], job_position: "some job_position", start_date: ~D[2010-04-17], type: "some type"}
    @update_attrs %{company_or_project: "some updated company_or_project", current_job: "some updated current_job", description: "some updated description", end_date: ~D[2011-05-18], job_position: "some updated job_position", start_date: ~D[2011-05-18], type: "some updated type"}
    @invalid_attrs %{company_or_project: nil, current_job: nil, description: nil, end_date: nil, job_position: nil, start_date: nil, type: nil}

    def work_experience_fixture(attrs \\ %{}) do
      {:ok, work_experience} =
        attrs
        |> Enum.into(@valid_attrs)
        |> WorkExperiences.create_work_experience()

      work_experience
    end

    test "list_work_experiences/0 returns all work_experiences" do
      work_experience = work_experience_fixture()
      assert WorkExperiences.list_work_experiences() == [work_experience]
    end

    test "get_work_experience!/1 returns the work_experience with given id" do
      work_experience = work_experience_fixture()
      assert WorkExperiences.get_work_experience!(work_experience.id) == work_experience
    end

    test "create_work_experience/1 with valid data creates a work_experience" do
      assert {:ok, %WorkExperience{} = work_experience} = WorkExperiences.create_work_experience(@valid_attrs)
      assert work_experience.company_or_project == "some company_or_project"
      assert work_experience.current_job == "some current_job"
      assert work_experience.description == "some description"
      assert work_experience.end_date == ~D[2010-04-17]
      assert work_experience.job_position == "some job_position"
      assert work_experience.start_date == ~D[2010-04-17]
      assert work_experience.type == "some type"
    end

    test "create_work_experience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkExperiences.create_work_experience(@invalid_attrs)
    end

    test "update_work_experience/2 with valid data updates the work_experience" do
      work_experience = work_experience_fixture()
      assert {:ok, %WorkExperience{} = work_experience} = WorkExperiences.update_work_experience(work_experience, @update_attrs)
      assert work_experience.company_or_project == "some updated company_or_project"
      assert work_experience.current_job == "some updated current_job"
      assert work_experience.description == "some updated description"
      assert work_experience.end_date == ~D[2011-05-18]
      assert work_experience.job_position == "some updated job_position"
      assert work_experience.start_date == ~D[2011-05-18]
      assert work_experience.type == "some updated type"
    end

    test "update_work_experience/2 with invalid data returns error changeset" do
      work_experience = work_experience_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkExperiences.update_work_experience(work_experience, @invalid_attrs)
      assert work_experience == WorkExperiences.get_work_experience!(work_experience.id)
    end

    test "delete_work_experience/1 deletes the work_experience" do
      work_experience = work_experience_fixture()
      assert {:ok, %WorkExperience{}} = WorkExperiences.delete_work_experience(work_experience)
      assert_raise Ecto.NoResultsError, fn -> WorkExperiences.get_work_experience!(work_experience.id) end
    end

    test "change_work_experience/1 returns a work_experience changeset" do
      work_experience = work_experience_fixture()
      assert %Ecto.Changeset{} = WorkExperiences.change_work_experience(work_experience)
    end
  end
end
