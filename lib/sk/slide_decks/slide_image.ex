defmodule Sk.SlideDecks.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_images" do
    field :content, :binary
    field :content_type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:content, :content_type])
    |> validate_required([:content, :content_type])
  end
end
