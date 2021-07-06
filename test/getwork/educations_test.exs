defmodule Getwork.EducationsTest do
  use Getwork.DataCase

  alias Getwork.Educations

  describe "educations" do
    alias Getwork.Educations.Education

    @valid_attrs %{city: "some city", end_date: ~D[2010-04-17], institution: "some institution", its_currently_attending: true, start_date: ~D[2010-04-17], type: "some type"}
    @update_attrs %{city: "some updated city", end_date: ~D[2011-05-18], institution: "some updated institution", its_currently_attending: false, start_date: ~D[2011-05-18], type: "some updated type"}
    @invalid_attrs %{city: nil, end_date: nil, institution: nil, its_currently_attending: nil, start_date: nil, type: nil}

    def education_fixture(attrs \\ %{}) do
      {:ok, education} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Educations.create_education()

      education
    end

    test "list_educations/0 returns all educations" do
      education = education_fixture()
      assert Educations.list_educations() == [education]
    end

    test "get_education!/1 returns the education with given id" do
      education = education_fixture()
      assert Educations.get_education!(education.id) == education
    end

    test "create_education/1 with valid data creates a education" do
      assert {:ok, %Education{} = education} = Educations.create_education(@valid_attrs)
      assert education.city == "some city"
      assert education.end_date == ~D[2010-04-17]
      assert education.institution == "some institution"
      assert education.its_currently_attending == true
      assert education.start_date == ~D[2010-04-17]
      assert education.type == "some type"
    end

    test "create_education/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Educations.create_education(@invalid_attrs)
    end

    test "update_education/2 with valid data updates the education" do
      education = education_fixture()
      assert {:ok, %Education{} = education} = Educations.update_education(education, @update_attrs)
      assert education.city == "some updated city"
      assert education.end_date == ~D[2011-05-18]
      assert education.institution == "some updated institution"
      assert education.its_currently_attending == false
      assert education.start_date == ~D[2011-05-18]
      assert education.type == "some updated type"
    end

    test "update_education/2 with invalid data returns error changeset" do
      education = education_fixture()
      assert {:error, %Ecto.Changeset{}} = Educations.update_education(education, @invalid_attrs)
      assert education == Educations.get_education!(education.id)
    end

    test "delete_education/1 deletes the education" do
      education = education_fixture()
      assert {:ok, %Education{}} = Educations.delete_education(education)
      assert_raise Ecto.NoResultsError, fn -> Educations.get_education!(education.id) end
    end

    test "change_education/1 returns a education changeset" do
      education = education_fixture()
      assert %Ecto.Changeset{} = Educations.change_education(education)
    end
  end
end
