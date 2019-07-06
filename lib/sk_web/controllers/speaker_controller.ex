defmodule SkWeb.SpeakerController do
  use SkWeb, :controller

  alias Sk.Accounts


  def index(conn, _params) do
    speakers = Accounts.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end

  def show(conn, %{"id" => id}) do
    speaker = Accounts.get_speaker(id)

    render(conn, "view.html", speaker: speaker)
  end

end
