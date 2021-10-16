defmodule SkWeb.PageControllerTest do
  use SkWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Speaker Karaoke"
  end
end
