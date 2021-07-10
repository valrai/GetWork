defmodule Getwork.Languages.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Languages
  alias Getwork.Languages.Language

  describe "delete_language" do
    test "should remove the correct language." do
      %{id: first_language_id} = insert!(:language)
      %{id: second_language_id} = insert!(:language)

      Languages.delete_language(first_language_id)
      languages = Repo.all(Language)

      assert match?([%Language{}], languages)
      assert hd(languages).id == second_language_id
    end

    test "should return a error if no language is found for the given name." do
      result = Ecto.UUID.generate() |> Languages.delete_language()

      assert match?({:error, 404, _}, result)
    end
  end
end
