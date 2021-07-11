defmodule Getwork.Claims do
  @moduledoc """
  The Claims context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Claims.Claim

  @doc """
  Returns the list of claims.

  ## Examples

      iex> list_claims()
      {:ok, [%Claim{}, ...}

      iex> list_claims()
      {:ok, []}

  """
  def list_claims do
    claims = Repo.all(Claim)
    {:ok, claims}
  end

  @doc """
  Creates a claim.

  ## Examples

      iex> create_claim(%{name: "new claim"})
      {:ok, %Claim{}}

      iex> create_claim(%{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_claim(attrs \\ %{}) do
    %Claim{}
    |> Claim.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a claim.

  ## Examples

      iex> update_claim(%Claim{}, %{name: "new claim"})
      {:ok, %Getwork.Claims.Claim{}}

      iex> update_claim(%Claim{}, %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_claim("c19763df-42ef-463b-9e78-86355f9d3673", %{name: "new claim"})
      {:ok, %Getwork.Claims.Claim{}}

      iex> update_claim("c19763df-42ef-463b-9e78-86355f9d3673", %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_claim("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{"name" => "new claim"})
      {:error, 404, "resource not found"}

  """
  def update_claim(%Claim{} = claim, attrs) do
    claim
    |> Claim.changeset(attrs)
    |> Repo.update()
  end

  def update_claim(id, attrs) do
    Claim
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      claim -> update_claim(claim, attrs)
    end
  end

  @doc """
  Deletes a claim.

  ## Examples

      iex> delete_claim(%Claim{})
      {:ok, %Getwork.Claims.Claim{}}

      iex> delete_claim(%Claim{})
      {:error, %Ecto.Changeset{}}

      iex> delete_claim("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Claims.Claim{}}

      iex> delete_claim("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_claim("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_claim(%Claim{} = claim), do: Repo.delete(claim)

  def delete_claim(id) do
    Claim
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      claim -> delete_claim(claim)
    end
  end
end
