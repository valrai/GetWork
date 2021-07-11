defmodule Getwork.Claims.DeleteTest do
  use Getwork.DataCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Claims
  alias Getwork.Claims.Claim

  describe "delete_claim" do
    test "should remove the correct claim." do
      %{id: first_claim_id} = insert!(:claim)
      %{id: second_claim_id} = insert!(:claim)

      Claims.delete_claim(first_claim_id)
      claims = Repo.all(Claim)

      assert match?([%Claim{}], claims)
      assert hd(claims).id == second_claim_id
    end

    test "should return a error if no claim is found for the given name." do
      result = Ecto.UUID.generate() |> Claims.delete_claim()

      assert match?({:error, 404, _}, result)
    end
  end
end
