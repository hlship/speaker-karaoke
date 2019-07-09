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

end
