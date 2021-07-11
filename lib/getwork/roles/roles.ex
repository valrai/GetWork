defmodule Getwork.Roles do
  @moduledoc """
  The Roles context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Roles.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      {:ok, [%Role{}, ...]}

      iex> list_roles()
      {:ok, []}

  """
  def list_roles do
    roles = Repo.all(Role)
    {:ok, roles}
  end

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{name: "new role"})
      {:ok, %Role{}}

      iex> create_role(%{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(%Role{}, %{name: "new role"})
      {:ok, %Getwork.Roles.Role{}}

      iex> update_role(%Role{}, %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_role("c19763df-42ef-463b-9e78-86355f9d3673", %{name: "new role"})
      {:ok, %Getwork.Roles.Role{}}

      iex> update_role("c19763df-42ef-463b-9e78-86355f9d3673", %{name: nil})
      {:error, %Ecto.Changeset{}}

      iex> update_role("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{"name" => "new role"})
      {:error, 404, "resource not found"}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def update_role(id, attrs) do
    Role
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      role -> update_role(role, attrs)
    end
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(%Role{})
      {:ok, %Getwork.Roles.Role{}}

      iex> delete_role(%Role{})
      {:error, %Ecto.Changeset{}}

      iex> delete_role("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Roles.Role{}}

      iex> delete_role("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_role("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_role(%Role{} = role), do: Repo.delete(role)

  def delete_role(id) do
    Role
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      role -> delete_role(role)
    end
  end
end
