defmodule GetworkWeb.UserView do
  use GetworkWeb, :view
  alias GetworkWeb.UserView
  alias GetworkWeb.RoleView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      username: user.username,
      is_active: user.is_active,
      suspension_end_date: user.suspension_end_date,
      roles: parse_roles(user.roles)
    }
  end

  defp parse_roles(roles) do
    if is_list(roles) do
      RoleView.render("index.json", roles: roles).data
    else
      roles
    end
  end
end
