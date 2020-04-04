defmodule SkWeb.SlideDeckController do
  use SkWeb, :controller

  alias Sk.Presentations
  alias Sk.Presentations.SlideDeck

  def index(conn, _params) do
    slide_decks = Presentations.list_slide_decks()
    render(conn, "index.html", slide_decks: slide_decks)
  end

  def new(conn, _params) do
    changeset = Presentations.change_slide_deck(%SlideDeck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"slide_deck" => slide_deck_params}) do
    case Presentations.create_slide_deck(slide_deck_params) do
      {:ok, slide_deck} ->
        conn
        |> put_flash(:info, "Slide deck created successfully.")
        |> redirect(to: Routes.slide_deck_path(conn, :show, slide_deck))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    slide_deck = Presentations.get_slide_deck!(id)
    render(conn, "show.html", slide_deck: slide_deck)
  end

  def edit(conn, %{"id" => id}) do
    slide_deck = Presentations.get_slide_deck!(id)
    changeset = Presentations.change_slide_deck(slide_deck)
    render(conn, "edit.html", slide_deck: slide_deck, changeset: changeset)
  end

  def update(conn, %{"id" => id, "slide_deck" => slide_deck_params}) do
    slide_deck = Presentations.get_slide_deck!(id)

    case Presentations.update_slide_deck(slide_deck, slide_deck_params) do
      {:ok, slide_deck} ->
        conn
        |> put_flash(:info, "Slide deck updated successfully.")
        |> redirect(to: Routes.slide_deck_path(conn, :show, slide_deck))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", slide_deck: slide_deck, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    slide_deck = Presentations.get_slide_deck!(id)
    {:ok, _slide_deck} = Presentations.delete_slide_deck(slide_deck)

    conn
    |> put_flash(:info, "Slide deck deleted successfully.")
    |> redirect(to: Routes.slide_deck_path(conn, :index))
  end
end
