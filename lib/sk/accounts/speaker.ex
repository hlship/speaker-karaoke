defmodule Sk.Accounts.Speaker do

  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :name, :string
    field :twitter_id, :string
    timestamps()
  end

  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :twitter_id])
    |> validate_required([:name, :twitter_id])
    |> validate_length(:name, min: 1, max: 50)
  end
end
