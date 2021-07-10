defmodule GetworkWeb.LanguageController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Languages.Language

  describe "update_language" do
    setup %{conn: conn} do
      insert!(:language)
      insert!(:language)
      la = insert!(:language)

      {:ok, conn: put_req_header(conn, "accept", "application/json"), language_id: la.id}
    end

    test "should update the correct language.", %{conn: conn, language_id: id} do
      language = %{"name" => "new name"}
      put(conn, Routes.language_path(conn, :update, id), language)

      updated_languages =
        Language
        |> where(name: ^language["name"])
        |> Repo.all()

      assert length(updated_languages) == 1
      assert hd(updated_languages).name == language["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      language_id: id
    } do
      conn = put(conn, Routes.language_path(conn, :update, id), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should return a error if no language is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()

      conn =
        put(conn, Routes.language_path(conn, :update, unregistered_id), %{
          "name" => "new name"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
