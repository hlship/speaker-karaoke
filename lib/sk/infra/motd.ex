defmodule Sk.Infra.MOTD do
  use Ecto.Schema
  import Ecto.Changeset


  schema "daily_messages" do
    field :expires_at, :naive_datetime, null: true
    field :message_text, :string

    timestamps()
  end

  @doc false
  def changeset(motd, attrs) do
    motd
    |> cast(attrs, [:message_text, :expires_at])
    |> validate_required([:message_text])
  end
end
