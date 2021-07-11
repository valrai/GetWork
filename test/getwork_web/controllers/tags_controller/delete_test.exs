defmodule GetworkWeb.TagController.DeleteTest do
  use GetworkWeb.ConnCase, async: true

  import Getwork.Factory

  alias Getwork.Repo
  alias Getwork.Tags.Tag

  describe "delete_tag" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should remove the correct tag.", %{conn: conn} do
      %{id: first_tag_id} = insert!(:tag)
      %{id: second_tag_id} = insert!(:tag)

      conn = delete(conn, Routes.tag_path(conn, :delete, first_tag_id))

      tags = Repo.all(Tag)

      assert response(conn, 204)
      assert length(tags) == 1
      assert hd(tags).id == second_tag_id
    end

    test "should return a error if no tag is found for the given name.", %{conn: conn} do
      unregistered_id = Ecto.UUID.generate()
      conn = delete(conn, Routes.tag_path(conn, :delete, unregistered_id))

      assert match?(%{"errors" => _}, json_response(conn, 404))
    end
  end
end
