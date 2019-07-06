defmodule SkWeb.SpeakerController do
  use SkWeb, :controller

  alias Sk.Accounts


  def index(conn, _params) do
    speakers = Accounts.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end
end
