defmodule Getwork.Tags.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Tags
  alias Getwork.Tags.Tag

  describe "update_tag" do
    setup do
      insert!(:tag)
      insert!(:tag)
      la = insert!(:tag)

      {:ok, tag_id: la.id}
    end

    test "should update the correct tag.", %{tag_id: id} do
      Tags.update_tag(id, %{"name" => "new name"})

      updated_tags =
        Tag
        |> where(name: "new name")
        |> Repo.all()

      assert length(updated_tags) == 1
      assert hd(updated_tags).id == id
      assert hd(updated_tags).name == "new name"
    end

    test "should return a error if any parameter fails in the validations.", %{
      tag_id: id
    } do
      result = Tags.update_tag(id, %{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should return a error if no tag is found for the given name." do
      result = Ecto.UUID.generate() |> Tags.update_tag(%{"name" => "new name"})

      assert match?({:error, 404, _}, result)
    end
  end
end
