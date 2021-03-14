defmodule Sk.Presentations.SlideDeck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_decks" do
    field :title, :string
    belongs_to :presenter, Sk.Accounts.Speaker

    timestamps()
  end

  def changeset(slide_deck, attrs) do
    slide_deck
    |> cast(attrs, [:title])
    |> validate_required([:title, :presenter_id])
  end
end
