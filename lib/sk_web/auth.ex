defmodule SkWeb.Auth do
  import Plug.Conn

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
end
