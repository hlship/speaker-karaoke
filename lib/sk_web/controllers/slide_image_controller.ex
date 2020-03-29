defmodule SkWeb.SlideImageController do
  use SkWeb, :controller

  alias Sk.Presentations
  alias Sk.Presentations.SlideImage

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_speaker]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_speaker) do
    slide_images = Presentations.list_slide_images_submitted_by(current_speaker)
    render(conn, "index.html", slide_images: slide_images)
  end

  def new(conn, _params, _current_speaker) do
    changeset = Presentations.change_slide_image(%SlideImage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"slide_image" => slide_image_params}, current_speaker) do
    case Presentations.create_slide_image(current_speaker, slide_image_params) do
      {:ok, slide_image} ->
        conn
        |> put_flash(:info, "Slide image created successfully.")
        |> redirect(to: Routes.slide_image_path(conn, :show, slide_image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_speaker) do
    slide_image = Presentations.get_slide_image_submitted_by!(current_speaker, id)
    render(conn, "show.html", slide_image: slide_image)
  end

  def edit(conn, %{"id" => id}, current_speaker) do
    slide_image = Presentations.get_slide_image_submitted_by!(current_speaker, id)
    changeset = Presentations.change_slide_image(slide_image)
    render(conn, "edit.html", slide_image: slide_image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "slide_image" => slide_image_params}, current_speaker) do
    slide_image = Presentations.get_slide_image_submitted_by!(current_speaker, id)

    case Presentations.update_slide_image(slide_image, slide_image_params) do
      {:ok, slide_image} ->
        conn
        |> put_flash(:info, "Slide image updated successfully.")
        |> redirect(to: Routes.slide_image_path(conn, :show, slide_image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", slide_image: slide_image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_speaker) do
    slide_image = Presentations.get_slide_image_submitted_by!(current_speaker, id)
    {:ok, _slide_image} = Presentations.delete_slide_image(slide_image)

    conn
    |> put_flash(:info, "Slide image deleted successfully.")
    |> redirect(to: Routes.slide_image_path(conn, :index))
  end
end
