defmodule SkWeb.SlideImageController do
  use SkWeb, :controller

  alias Sk.SlideShow
  alias Sk.SlideShow.SlideImage

  def index(conn, _params) do
    slide_images = SlideShow.list_slide_images()
    render(conn, "index.html", slide_images: slide_images)
  end

  def new(conn, _params) do
    changeset = SlideShow.change_slide_image(%SlideImage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"slide_image" => slide_image_params}) do
    case SlideShow.create_slide_image(slide_image_params) do
      {:ok, slide_image} ->
        conn
        |> put_flash(:info, "Slide image created successfully.")
        |> redirect(to: Routes.slide_image_path(conn, :show, slide_image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    slide_image = SlideShow.get_slide_image!(id)
    render(conn, "show.html", slide_image: slide_image)
  end

  def edit(conn, %{"id" => id}) do
    slide_image = SlideShow.get_slide_image!(id)
    changeset = SlideShow.change_slide_image(slide_image)
    render(conn, "edit.html", slide_image: slide_image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "slide_image" => slide_image_params}) do
    slide_image = SlideShow.get_slide_image!(id)

    case SlideShow.update_slide_image(slide_image, slide_image_params) do
      {:ok, slide_image} ->
        conn
        |> put_flash(:info, "Slide image updated successfully.")
        |> redirect(to: Routes.slide_image_path(conn, :show, slide_image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", slide_image: slide_image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    slide_image = SlideShow.get_slide_image!(id)
    {:ok, _slide_image} = SlideShow.delete_slide_image(slide_image)

    conn
    |> put_flash(:info, "Slide image deleted successfully.")
    |> redirect(to: Routes.slide_image_path(conn, :index))
  end
end
