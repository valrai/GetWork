defmodule Getwork.Qualifications do
  @moduledoc """
  The Qualifications context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Qualifications.Education

  @doc """
  Returns the list of qualifications.

  ## Examples

      iex> list_qualifications()
      [%Education{}, ...]

  """
  def list_qualifications do
    Repo.all(Education)
  end

  @doc """
  Gets a single education.

  Raises `Ecto.NoResultsError` if the Education does not exist.

  ## Examples

      iex> get_education!(123)
      %Education{}

      iex> get_education!(456)
      ** (Ecto.NoResultsError)

  """
  def get_education!(id), do: Repo.get!(Education, id)

  @doc """
  Creates a education.

  ## Examples

      iex> create_education(%{field: value})
      {:ok, %Education{}}

      iex> create_education(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_education(attrs \\ %{}) do
    %Education{}
    |> Education.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a education.

  ## Examples

      iex> update_education(education, %{field: new_value})
      {:ok, %Education{}}

      iex> update_education(education, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_education(%Education{} = education, attrs) do
    education
    |> Education.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a education.

  ## Examples

      iex> delete_education(education)
      {:ok, %Education{}}

      iex> delete_education(education)
      {:error, %Ecto.Changeset{}}

  """
  def delete_education(%Education{} = education) do
    Repo.delete(education)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking education changes.

  ## Examples

      iex> change_education(education)
      %Ecto.Changeset{data: %Education{}}

  """
  def change_education(%Education{} = education, attrs \\ %{}) do
    Education.changeset(education, attrs)
  end
end
