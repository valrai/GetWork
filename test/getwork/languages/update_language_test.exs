defmodule Getwork.Languages.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Languages
  alias Getwork.Languages.Language

  describe "update_language" do
    setup do
      insert!(:language)
      insert!(:language)
      la = insert!(:language)

      {:ok, language_id: la.id}
    end

    test "should update the correct language.", %{language_id: id} do
      Languages.update_language(id, %{"name" => "new name"})

      updated_languages =
        Language
        |> where(name: "new name")
        |> Repo.all()

      assert length(updated_languages) == 1
      assert hd(updated_languages).id == id
      assert hd(updated_languages).name == "new name"
    end

    test "should return a error if any parameter fails in the validations.", %{
      language_id: id
    } do
      result = Languages.update_language(id, %{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should return a error if no language is found for the given id." do
      result = Ecto.UUID.generate() |> Languages.update_language(%{"name" => "new name"})

      assert match?({:error, 404, _}, result)
    end
  end
end
