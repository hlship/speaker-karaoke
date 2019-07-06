defmodule SkWeb.SpeakerView do

  use SkWeb, :view

  alias Sk.Accounts

  def first_name(%Accounts.Speaker{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end


end
