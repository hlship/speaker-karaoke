defmodule SpeakerkaraokeWeb.PageController do
  use SpeakerkaraokeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
