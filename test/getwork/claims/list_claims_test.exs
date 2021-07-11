defmodule Getwork.Claims.ListTest do
  use Getwork.DataCase, async: true
  import Getwork.Factory
  alias Getwork.Claims

  describe "list_claims" do
    test "should list all registered claims." do
      insert!(:claim)
      insert!(:claim)
      insert!(:claim)

      {:ok, claims} = Claims.list_claims()

      assert length(claims) == 3
    end

    test "should return a empty list if no claim is found." do
      {:ok, claims} = Claims.list_claims()

      assert claims == []
    end
  end
end
