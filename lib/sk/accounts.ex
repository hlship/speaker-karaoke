defmodule Sk.Accounts do
  @moduledoc """
  Accounts context.
  """

  alias Sk.Accounts.Speaker

  def list_speakers do
    [
      %Speaker{id: "100", name: "Howard Lewis Ship", twitter_id: "hlship"},
      %Speaker{id: "110", name: "Meryln Albery-Speyer", twitter_id: "curiousattemptbunny"},
      %Speaker{id: "500", name: "Jacob Lewis Ship", twitter_id: "minecraftjacob"}
    ]
  end

  def get_speaker(id) do
    Enum.find(list_speakers(), fn m -> m.id == id end)
  end

  def get_speaker_by(params) do
    Enum.find(list_speakers(), fn m ->
      Enum.all?(params, fn {key, val} -> Map.get(m, key) == val end)
    end)
  end

end
