defmodule Getwork.Tags.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Tags
  alias Getwork.Tags.Tag

  describe "delete_tag" do
    test "should remove the correct tag." do
      %{id: first_tag_id} = insert!(:tag)
      %{id: second_tag_id} = insert!(:tag)

      Tags.delete_tag(first_tag_id)
      tags = Repo.all(Tag)

      assert match?([%Tag{}], tags)
      assert hd(tags).id == second_tag_id
    end

    test "should return a error if no tag is found for the given name." do
      result = Ecto.UUID.generate() |> Tags.delete_tag()

      assert match?({:error, 404, _}, result)
    end
  end
end
