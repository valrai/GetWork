defmodule Getwork.Claims.UpdateTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Claims
  alias Getwork.Claims.Claim

  describe "update_claim" do
    setup do
      insert!(:claim)
      insert!(:claim)
      cl = insert!(:claim)

      {:ok, claim_id: cl.id}
    end

    test "should update the correct claim.", %{claim_id: id} do
      Claims.update_claim(id, %{"name" => "new name"})

      updated_claims =
        Claim
        |> where(name: "new name")
        |> Repo.all()

      assert length(updated_claims) == 1
      assert hd(updated_claims).id == id
      assert hd(updated_claims).name == "new name"
    end

    test "should return a error if any parameter fails in the validations.", %{
      claim_id: id
    } do
      result = Claims.update_claim(id, %{"name" => nil})

      assert match?({:error, %Ecto.Changeset{}}, result)
    end

    test "should return a error if no claim is found for the given id." do
      result = Ecto.UUID.generate() |> Claims.update_claim(%{"name" => "new name"})

      assert match?({:error, 404, _}, result)
    end
  end
end
