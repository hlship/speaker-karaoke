defmodule SkWeb.SpeakerController do
  use SkWeb, :controller

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
    changeset = Accounts.change_speaker(%Speaker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"speaker" => params}) do
    case  Accounts.create_speaker(params) do
      {:ok, speaker}  ->
        conn
        |> put_flash(:info, "#{speaker.name} created")
        |> redirect(to: Routes.speaker_path(conn, :index))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end

  end
