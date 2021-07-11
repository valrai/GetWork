defmodule GetworkWeb.TagController.UpdateTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory
  import Ecto.Query

  alias Getwork.Repo
  alias Getwork.Tags.Tag

  describe "update_tag" do
    setup %{conn: conn} do
      insert!(:tag)
      insert!(:tag)
      la = insert!(:tag)

      {:ok, conn: put_req_header(conn, "accept", "application/json"), tag_id: la.id}
    end

    test "should update the correct tag.", %{conn: conn, tag_id: id} do
      tag = %{"name" => "new name"}
      put(conn, Routes.tag_path(conn, :update, id), tag)

      updated_tags =
        Tag
        |> where(name: ^tag["name"])
        |> Repo.all()

      assert length(updated_tags) == 1
      assert hd(updated_tags).name == tag["name"]
    end

    test "should return a error if any parameter fails in the validations.", %{
      conn: conn,
      tag_id: id
    } do
      conn = put(conn, Routes.tag_path(conn, :update, id), %{"name" => nil})

      assert match?(%{"errors" => _}, json_response(conn, 422))
    end

    test "should return a error if no tag is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()

      conn =
        put(conn, Routes.tag_path(conn, :update, unregistered_id), %{
          "name" => "new name"
        })

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
