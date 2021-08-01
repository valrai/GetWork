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

      iex> list_users(%{"field" => "value"})
      {:ok, [%User{"field" => "value"}, ...]}

  """
  def list_users do
    users =
      User
      |> Repo.all()
      |> Repo.preload(:roles)

    {:ok, users}
  end

  def list_users(params) do
    users =
      User
      |> apply_filter(params, "is_active")
      |> apply_filter(params, "email")
      |> apply_filter(params, "username")
      |> Repo.all()
      |> Repo.preload(:roles)

    {:ok, users}
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %User{}}

      iex> get_user!("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def get_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> {:ok, Repo.preload(user, :roles)}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{email: "valid@email.com", password: "123456"})
      {:ok, %User{}}

      iex> create_user(%{email: "invalid email", password: "123456"})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    result =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    with {:ok, user} <- result do
      {:ok, Repo.preload(user, :roles)}
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(%User{}, %{email: "valid@email.com", password: "123456"})
      {:ok, %Getwork.Users.User{}}

      iex> update_user(%User{}, %{email: "invalid email", password: "123456"})
      {:error, %Ecto.Changeset{}}

      iex> update_user("c19763df-42ef-463b-9e78-86355f9d3673", %{email: "valid@email.com", password: "123456"})
      {:ok, %Getwork.Users.User{}}

      iex> update_user("c19763df-42ef-463b-9e78-86355f9d3673", %{email: "invalid email", password: "123456"})
      {:error, %Ecto.Changeset{}}

      iex> update_user("d2642c20-ec14-408d-9324-7fd4e76ffcc1", %{email: "valid@email.com", password: "123456"})
      {:error, 404, "resource not found"}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user(id, attrs) do
    User
    |> Repo.get(id)
    |> Repo.preload(:roles)
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> update_user(user, attrs)
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(%User{})
      {:ok, %Getwork.Users.User{}}

      iex> delete_user(%User{})
      {:error, %Ecto.Changeset{}}

      iex> delete_user("c19763df-42ef-463b-9e78-86355f9d3673")
      {:ok, %Getwork.Users.User{}}

      iex> delete_user("c19763df-42ef-463b-9e78-86355f9d3673")
      {:error, %Ecto.Changeset{}}

      iex> delete_user("d2642c20-ec14-408d-9324-7fd4e76ffcc1")
      {:error, 404, "resource not found"}

  """
  def delete_user(%User{} = user), do: Repo.delete(user)

  def delete_user(id) do
    User
    |> Repo.get(id)
    |> case do
      nil -> {:error, 404, "resource not found"}
      user -> delete_user(user)
    end
  end

  defp apply_filter(query, params, param_name) do
    if Map.has_key?(params, param_name) do
      param_value = Map.get(params, param_name)
      param_name = String.to_existing_atom(param_name)
      filter = [{param_name, param_value}]

      where(query, ^filter)
    else
      query
    end
  end
end
