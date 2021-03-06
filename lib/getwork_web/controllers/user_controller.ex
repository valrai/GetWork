defmodule GetworkWeb.UserController do
  use GetworkWeb, :controller

  alias Getwork.Users
  alias Getwork.Users.User

  action_fallback GetworkWeb.FallbackController

  def index(conn, params) do
    with {:ok, users} <- Users.list_users(params) do
      render(conn, "index.json", users: users)
    end
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, user_params) do
    with {:ok, %User{} = user} <- Users.update_user(user_params["id"], user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Users.delete_user(id) do
      send_resp(conn, :no_content, "")
    end
  end

  def suspend_account(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.suspend_user_account(id) do
      render(conn, "show.json", user: user)
    end
  end
end
