defmodule SkWeb.SlideImageControllerTest do
  use SkWeb.ConnCase

  alias Sk.Presentations

  @create_attrs %{source_url: "some source_url"}
  @update_attrs %{source_url: "some updated source_url"}
  @invalid_attrs %{source_url: nil}

  def fixture(:slide_image) do
    {:ok, slide_image} = Presentations.create_slide_image(@create_attrs)
    slide_image
  end

  describe "index" do
    test "lists all slide_images", %{conn: conn} do
      conn = get(conn, Routes.slide_image_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Slide images"
    end
  end

  describe "new slide_image" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.slide_image_path(conn, :new))
      assert html_response(conn, 200) =~ "New Slide image"
    end
  end

  describe "create slide_image" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.slide_image_path(conn, :create), slide_image: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.slide_image_path(conn, :show, id)

      conn = get(conn, Routes.slide_image_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Slide image"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.slide_image_path(conn, :create), slide_image: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Slide image"
    end
  end

  describe "edit slide_image" do
    setup [:create_slide_image]

    test "renders form for editing chosen slide_image", %{conn: conn, slide_image: slide_image} do
      conn = get(conn, Routes.slide_image_path(conn, :edit, slide_image))
      assert html_response(conn, 200) =~ "Edit Slide image"
    end
  end

  describe "update slide_image" do
    setup [:create_slide_image]

    test "redirects when data is valid", %{conn: conn, slide_image: slide_image} do
      conn = put(conn, Routes.slide_image_path(conn, :update, slide_image), slide_image: @update_attrs)
      assert redirected_to(conn) == Routes.slide_image_path(conn, :show, slide_image)

      conn = get(conn, Routes.slide_image_path(conn, :show, slide_image))
      assert html_response(conn, 200) =~ "some updated source_url"
    end

    test "renders errors when data is invalid", %{conn: conn, slide_image: slide_image} do
      conn = put(conn, Routes.slide_image_path(conn, :update, slide_image), slide_image: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Slide image"
    end
  end

  describe "delete slide_image" do
    setup [:create_slide_image]

    test "deletes chosen slide_image", %{conn: conn, slide_image: slide_image} do
      conn = delete(conn, Routes.slide_image_path(conn, :delete, slide_image))
      assert redirected_to(conn) == Routes.slide_image_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.slide_image_path(conn, :show, slide_image))
      end
    end
  end

  defp create_slide_image(_) do
    slide_image = fixture(:slide_image)
    {:ok, slide_image: slide_image}
  end
end
