defmodule GetworkWeb.RoleController do
  use GetworkWeb, :controller

  alias Getwork.Roles
  alias Getwork.Roles.Role

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    with {:ok, roles} <- Roles.list_roles() do
      render(conn, "index.json", roles: roles)
    end
  end

  def create(conn, role_params) do
    with {:ok, %Role{} = role} <- Roles.create_role(role_params) do
      conn
      |> put_status(:created)
      |> render("show.json", role: role)
    end
  end

  def update(conn, role_params) do
    with {:ok, %Role{} = role} <- Roles.update_role(role_params["id"], role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Role{}} <- Roles.delete_role(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
