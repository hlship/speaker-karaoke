defmodule SKWeb.PageControllerTest do
  use SKWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Speaker Karaoke"
  end
end
