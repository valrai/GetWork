defmodule GetworkWeb.LanguageController.DeleteTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Languages.Language

  describe "delete_language" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should remove the correct language.", %{conn: conn} do
      %{id: first_language_id} = insert!(:language)
      %{id: second_language_id} = insert!(:language)

      conn = delete(conn, Routes.language_path(conn, :delete, first_language_id))

      languages = Repo.all(Language)

      assert response(conn, 204)
      assert length(languages) == 1
      assert hd(languages).id == second_language_id
    end

    test "should return a error if no language is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()
      conn = delete(conn, Routes.language_path(conn, :delete, unregistered_id))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
