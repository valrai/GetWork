defmodule Getwork.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Getwork.Repo
  alias Getwork.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      {:ok, [%User{}, ...]}

      iex> list_users()
      {:ok, []}

  """
  def list_users do
    users = Repo.all(User)
    {:ok, users}
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      {:ok, %User{}}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user!(456)
      {:error, 404, "resource not found"}

  """
  def get_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(%{"id" => 123, "field" => new_value})
      {:ok, %User{}}

      iex> update_user(%{"id" => 456, "field" => new_value})
      {:error, 404, "resource not found"}

      iex> update_user(%{"id" => 123, "field" => bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user(attrs) do
    User
    |> Repo.get(attrs["id"])
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> update_user(user, attrs)
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(123)
      {:ok, %User{}}

      iex> delete_user(456)
      {:error, 404, "resource not found"}

  """
  def delete_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> Repo.delete(user)
    end
  end
end
