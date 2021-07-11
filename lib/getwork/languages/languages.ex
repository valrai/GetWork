defmodule Getwork.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Languages.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list_languages()
      {:ok, [%Language{}, ...]}

  """
  def list_languages do
    languages = Repo.all(Language)
    {:ok, languages}
  end

  @doc """
  Creates a language.

  ## Examples

      iex> create_language(%{name: "new language"})
      {:ok, %Getwork.Languages.Language{}}

      iex> create_language(%{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a language.

  ## Examples

      iex> update_language(%Language{}, %{name: "new language"})
      {:ok, %Getwork.Languages.Language{}}

      iex> update_language(%Language{}, %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_language("c19763df-42ef-463b-9e78-86355f9d3673", %{name: "new language"})
      {:ok, %Getwork.Languages.Language{}}

      iex> update_language("c19763df-42ef-463b-9e78-86355f9d3673", %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_language("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{"name" => "new language"})
      {:error, 404, "resource not found"}

  """
  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  def update_language(id, attrs) do
    Language
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      language -> update_language(language, attrs)
    end
  end

  @doc """
  Deletes a language.

  ## Examples

      iex> delete_language(%Language{})
      {:ok, %Getwork.Languages.Language{}}

      iex> delete_language(%Language{})
      {:error, %Ecto.Changeset{}}

      iex> delete_language("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Languages.Language{}}

      iex> delete_language("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_language("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_language(%Language{} = language), do: Repo.delete(language)

  def delete_language(id) do
    Language
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      language -> delete_language(language)
    end
  end
end
