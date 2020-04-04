defmodule SkWeb.SlideDeckControllerTest do
  use SkWeb.ConnCase

  alias Sk.Presentations

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:slide_deck) do
    {:ok, slide_deck} = Presentations.create_slide_deck(@create_attrs)
    slide_deck
  end

  describe "index" do
    test "lists all slide_decks", %{conn: conn} do
      conn = get(conn, Routes.slide_deck_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Slide decks"
    end
  end

  describe "new slide_deck" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.slide_deck_path(conn, :new))
      assert html_response(conn, 200) =~ "New Slide deck"
    end
  end

  describe "create slide_deck" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.slide_deck_path(conn, :create), slide_deck: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.slide_deck_path(conn, :show, id)

      conn = get(conn, Routes.slide_deck_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Slide deck"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.slide_deck_path(conn, :create), slide_deck: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Slide deck"
    end
  end

  describe "edit slide_deck" do
    setup [:create_slide_deck]

    test "renders form for editing chosen slide_deck", %{conn: conn, slide_deck: slide_deck} do
      conn = get(conn, Routes.slide_deck_path(conn, :edit, slide_deck))
      assert html_response(conn, 200) =~ "Edit Slide deck"
    end
  end

  describe "update slide_deck" do
    setup [:create_slide_deck]

    test "redirects when data is valid", %{conn: conn, slide_deck: slide_deck} do
      conn = put(conn, Routes.slide_deck_path(conn, :update, slide_deck), slide_deck: @update_attrs)
      assert redirected_to(conn) == Routes.slide_deck_path(conn, :show, slide_deck)

      conn = get(conn, Routes.slide_deck_path(conn, :show, slide_deck))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, slide_deck: slide_deck} do
      conn = put(conn, Routes.slide_deck_path(conn, :update, slide_deck), slide_deck: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Slide deck"
    end
  end

  describe "delete slide_deck" do
    setup [:create_slide_deck]

    test "deletes chosen slide_deck", %{conn: conn, slide_deck: slide_deck} do
      conn = delete(conn, Routes.slide_deck_path(conn, :delete, slide_deck))
      assert redirected_to(conn) == Routes.slide_deck_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.slide_deck_path(conn, :show, slide_deck))
      end
    end
  end

  defp create_slide_deck(_) do
    slide_deck = fixture(:slide_deck)
    {:ok, slide_deck: slide_deck}
  end
end
