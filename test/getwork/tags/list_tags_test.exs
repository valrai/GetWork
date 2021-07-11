defmodule Getwork.Tag.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Tags

  describe "list_tags" do
    test "should list all registered tags." do
      insert!(:tag)
      insert!(:tag)
      insert!(:tag)

      {:ok, tags} = Tags.list_tags()

      assert length(tags) == 3
    end

    test "should return a empty list if no tag is found." do
      {:ok, tags} = Tags.list_tags()

      assert tags == []
    end
  end
end
