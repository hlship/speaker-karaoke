defmodule SkWeb.SpeakerController do
  use SkWeb, :controller

  plug :authenticate when action in [:index, :show]

  alias Sk.Accounts
  alias Sk.Accounts.Speaker

  def index(conn, _params) do
    speakers = Accounts.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end

  def show(conn, %{"id" => id}) do
    speaker = Accounts.get_speaker(id)

    render(conn, "view.html", speaker: speaker)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%Speaker{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"speaker" => speaker_params}) do
    case Accounts.register_speaker(speaker_params) do
      {:ok, speaker} ->
        conn
        |> SkWeb.Auth.login(speaker)
        |> put_flash(:info, "#{speaker.name} created")
        |> redirect(to: Routes.speaker_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
      end
    end

  def authenticate(conn, _opts) do
    if conn.assigns.current_speaker do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  end
