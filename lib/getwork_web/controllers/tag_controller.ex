defmodule GetworkWeb.TagController do
  use GetworkWeb, :controller

  alias Getwork.Tags
  alias Getwork.Tags.Tag

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    with {:ok, tags} <- Tags.list_tags() do
      render(conn, "index.json", tags: tags)
    end
  end

  def create(conn, tag_params) do
    with {:ok, %Tag{} = tag} <- Tags.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> render("show.json", tag: tag)
    end
  end

  def update(conn, tag_params) do
    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag_params["id"], tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Tag{}} <- Tags.delete_tag(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
