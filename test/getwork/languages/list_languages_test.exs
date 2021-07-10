defmodule Getwork.Languages.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Languages

  describe "list_languages" do
    test "should list all registered languages." do
      insert!(:language)
      insert!(:language)
      insert!(:language)

      {:ok, languages} = Languages.list_languages()

      assert length(languages) == 3
    end

    test "should return a empty list if no language is found." do
      {:ok, languages} = Languages.list_languages()

      assert languages == []
    end
  end
end
