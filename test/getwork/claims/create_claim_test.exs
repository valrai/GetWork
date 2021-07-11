defmodule Getwork.Claims.CreateTest do
  use Getwork.DataCase, async: true

  alias Getwork.Claims
  alias Getwork.Claims.Claim

  describe "create_claim" do
    test "should create a new claim." do
      {:ok, %Claim{id: id, name: name}} = Claims.create_claim(%{"name" => "valid name"})

      refute is_nil(id)
      assert name == "valid name"
    end

    test "should return a error if any parameter fails in the validations." do
      result = Claims.create_claim(%{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end
  end
end
