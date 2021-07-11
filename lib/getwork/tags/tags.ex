defmodule Getwork.Tags do
  @moduledoc """
  The Tags context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Tags.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      {:ok, [%Tag{}, ...]}

  """
  def list_tags do
    tags = Repo.all(Tag)
    {:ok, tags}
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{name: "new tag"})
      {:ok, %Getwork.Tags.%Tag{}}

      iex> create_tag(%{name: ni})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{name: "new tag"})
      {:ok, %Getwork.Tags.%Tag{}}

      iex> update_tag(tag, %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_tag("c19763df-42ef-463b-9e78-86355f9d3673", %{name: "new tag"})
      {:ok, %Getwork.Tags.%Tag{}}

      iex> update_tag("c19763df-42ef-463b-9e78-86355f9d3673", %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_tag("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{"name" => "new tag"})
      {:error, 404, "resource not found"}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def update_tag(id, attrs) do
    Tag
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      tag -> update_tag(tag, attrs)
    end
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(%Tag{})
      {:ok, %Getwork.Tags.Tag{}}

      iex> delete_tag(%Tag{})
      {:error, %Ecto.Changeset{}}

      iex> delete_tag("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Tags.Tag{}}

      iex> delete_tag("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_tag("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def delete_tag(id) do
    Tag
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      tag -> delete_tag(tag)
    end
  end
end
