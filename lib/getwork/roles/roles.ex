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
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Gets a single role.

  ## Examples

      iex> get_role(123)
      {:ok, %Role{}}

      iex> get_role(456)
      {:error, 404, "resource not found"}

  """
  def get_role(id) do
    Role
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      role -> {:ok, role}
    end
  end

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
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

      iex> update_role(%{"id" => 123, "field" => new_value})
      {:ok, %Role{}}

      iex> update_role(%{"id" => 123, "field" => bad_value})
      {:error, %Ecto.Changeset{}}

      iex> update_role(%{"id" => 465, "field" => new_value})
      {:error, 404, "resource not found"}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def update_role(attrs) do
    Role
    |> Repo.get(attrs["id"])
    |> case do
      nil -> {:error, 404, "resource not found"}
      role -> update_role(role, attrs)
    end
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(123)
      {:ok, %Role{}}

      iex> delete_role(123)
      {:error, %Ecto.Changeset{}}

      iex> delete_role(456)
      {:error, 404, "resource not found"}

  """
  def delete_role(id) do
    Role
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      role -> Repo.delete(role)
    end
  end
end
