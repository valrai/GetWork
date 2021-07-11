defmodule GetworkWeb.TagController.IndexTest do
  use GetworkWeb.ConnCase, async: true
  import Getwork.Factory

  describe "list_tags" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should list all registered tags.", %{conn: conn} do
      insert!(:tag)
      insert!(:tag)
      insert!(:tag)

      conn = get(conn, Routes.tag_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 3
    end

    test "should return a empty list if no tag is found.", %{conn: conn} do
      conn = get(conn, Routes.tag_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end
end
