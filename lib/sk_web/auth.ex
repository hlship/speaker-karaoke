defmodule SkWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias SkWeb.Router.Helpers, as: Routes


  def init(opts), do: opts

  def call(conn, _opts) do
    speaker_id = get_session(conn, :speaker_id)
    speaker = speaker_id && Sk.Accounts.get_speaker(speaker_id)
    assign(conn, :current_speaker, speaker)
  end

  def login(conn, speaker) do
    conn
    |> assign(:current_speaker, speaker)
    |> put_session(:speaker_id, speaker.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_speaker do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

end
