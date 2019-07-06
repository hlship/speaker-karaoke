defmodule SkWeb.SpeakerView do

  use SkWeb, :view

  alias Sk.Accounts.Speaker

  def first_name(%Speaker{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end


end
