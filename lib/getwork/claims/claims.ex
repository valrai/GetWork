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
  Gets a single claim.

  Raises `Ecto.NoResultsError` if the Claim does not exist.

  ## Examples

      iex> get_claim!(123)
      %Claim{}

      iex> get_claim!(456)
      ** (Ecto.NoResultsError)

  """
  def get_claim!(id), do: Repo.get!(Claim, id)

  @doc """
  Gets a single claim.

  ## Examples

      iex> get_claim(123)
      {:ok, %Claim{}}

      iex> get_claim(456)
      {:error, 404, "resource not found"}

  """
  def get_claim(id) do
    Claim
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      claim -> {:ok, claim}
    end
  end

  @doc """
  Creates a claim.

  ## Examples

      iex> create_claim(%{field: value})
      {:ok, %Claim{}}

      iex> create_claim(%{field: bad_value})
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

      iex> update_claim(%{"id" => 123, "field" => new_value})
      {:ok, %Claim{}}

      iex> update_claim(%{"id" => 123, "field" => bad_value})
      {:error, %Ecto.Changeset{}}

      iex> update_claim(%{"id" => 456, "field" => new_value})
      {:error, 404, "resource not found"}

  """
  def update_claim(attrs) do
    Claim
    |> Repo.get(attrs["id"])
    |> case do
      nil -> {:error, 404, "resource not found"}
      claim -> update_claim(claim, attrs)
    end
  end

  defp update_claim(%Claim{} = claim, attrs) do
    claim
    |> Claim.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a claim.

  ## Examples

      iex> delete_claim(123)
      {:ok, %Claim{}}

      iex> delete_claim(456)
      {:error, 404, "resource not found"}

  """
  def delete_claim(id) do
    Claim
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      claim -> Repo.delete(claim)
    end
  end
end
