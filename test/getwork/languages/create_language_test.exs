defmodule Getwork.Languages.CreateTest do
  use Getwork.DataCase, async: true

  alias Getwork.Languages
  alias Getwork.Languages.Language

  describe "create_language" do
    test "should create a new language." do
      {:ok, %Language{id: id, name: name}} = Languages.create_language(%{"name" => "valid name"})

      refute is_nil(id)
      assert name == "valid name"
    end

    test "should return a error if any parameter fails in the validations." do
      result = Languages.create_language(%{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end
  end
end
