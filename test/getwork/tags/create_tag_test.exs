defmodule Getwork.Tags.CreateTest do
  use Getwork.DataCase, async: true

  alias Getwork.Tags
  alias Getwork.Tags.Tag

  describe "create_tag" do
    test "should create a new tag." do
      {:ok, %Tag{id: id, name: name}} = Tags.create_tag(%{"name" => "valid name"})

      refute is_nil(id)
      assert name == "valid name"
    end

    test "should return a error if any parameter fails in the validations." do
      result = Tags.create_tag(%{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end
  end
end
