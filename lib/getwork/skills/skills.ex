defmodule Getwork.Skills do
  @moduledoc """
  The Skills context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Skills.Skill

  @doc """
  Returns the list of skill.

  ## Examples

      iex> list_skills()
      {:ok, [%Skill{}, ...]}

  """
  def list_skills do
    skills = Repo.all(Skill)
    {:ok, skills}
  end

  @doc """
  Creates a skill.

  ## Examples

      iex> create_skill(%{name: "new skill"})
      {:ok, %Skill{}}

      iex> create_skill(%{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill(attrs \\ %{}) do
    %Skill{}
    |> Skill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill.

  ## Examples

      iex> update_skill(%Skill{}, %{name: "new skill"})
      {:ok, %Getwork.Skills.Skill{}}

      iex> update_skill(%Skill{}, %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_skill("c19763df-42ef-463b-9e78-86355f9d3673", %{name: "new skill"})
      {:ok, %Getwork.Skills.Skill{}}

      iex> update_skill("c19763df-42ef-463b-9e78-86355f9d3673", %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_skill("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{"name" => "new skill"})
      {:error, 404, "resource not found"}

  """
  def update_skill(%Skill{} = skill, attrs) do
    skill
    |> Skill.changeset(attrs)
    |> Repo.update()
  end

  def update_skill(id, attrs) do
    Skill
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      skill -> update_skill(skill, attrs)
    end
  end

  @doc """
  Deletes a skill.

  ## Examples

      iex> delete_skill(%Skill{})
      {:ok, %Getwork.Skills.Skill{}}

      iex> delete_skill(%Skill{})
      {:error, %Ecto.Changeset{}}

      iex> delete_skill("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Skills.Skill{}}

      iex> delete_skill("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_skill("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_skill(%Skill{} = skill) do
    Repo.delete(skill)
  end

  def delete_skill(id) do
    Skill
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      skill -> delete_skill(skill)
    end
  end
end
