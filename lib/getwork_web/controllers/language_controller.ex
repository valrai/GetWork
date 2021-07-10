defmodule GetworkWeb.LanguageController do
  use GetworkWeb, :controller

  alias Getwork.Languages
  alias Getwork.Languages.Language

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    with {:ok, languages} <- Languages.list_languages() do
      render(conn, "index.json", languages: languages)
    end
  end

  def create(conn, language_params) do
    with {:ok, %Language{} = language} <- Languages.create_language(language_params) do
      conn
      |> put_status(:created)
      |> render("show.json", language: language)
    end
  end

  def update(conn, language_params) do
    with {:ok, %Language{} = language} <-
           Languages.update_language(language_params["id"], language_params) do
      render(conn, "show.json", language: language)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Language{}} <- Languages.delete_language(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
