defmodule SkWeb.SessionController do
  use SkWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"speaker_id" => speaker_id,
                                    "password" => pass}}) do
    case Sk.Accounts.auth_by_speaker_id_and_pass(speaker_id, pass) do
      {:ok, speaker} ->
        conn
        |> SkWeb.Auth.login(speaker)
        |> put_flash(:info, "Welcome back #{speaker.name}")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid name/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> SkWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end


end
