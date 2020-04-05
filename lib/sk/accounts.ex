defmodule Sk.Accounts do
  @moduledoc """
  Accounts context.
  """

  alias Sk.Repo
  alias Sk.Accounts.Speaker

  def list_speakers, do: Repo.all(Speaker)

  def get_speaker(id), do: Repo.get(Speaker, id)

  def get_speaker!(id), do: Repo.get!(Speaker, id)

  def get_speaker_by(params), do: Repo.get_by(Speaker, params)

  def change_speaker(%Speaker{} = speaker) do
    Speaker.changeset(speaker, %{})
  end

  def create_speaker(attrs \\ %{}) do
    %Speaker{}
    |> Speaker.changeset(attrs)
    |> Repo.insert()
  end

  def change_registration(%Speaker{} = speaker, params) do
    Speaker.registration_changeset(speaker, params)
  end

  def register_speaker(attrs \\ %{}) do
    %Speaker{}
    |> Speaker.registration_changeset(attrs)
    |> Repo.insert()
  end

  def auth_by_twitter_id_and_pass(twitter_id, given_pass) do
    speaker = get_speaker_by(twitter_id: twitter_id)

    cond do
      speaker && Pbkdf2.verify_pass(given_pass, speaker.password_hash) ->
        {:ok, speaker}

      speaker ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end

end
