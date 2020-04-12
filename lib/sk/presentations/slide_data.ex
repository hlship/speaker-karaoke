defmodule Sk.Presentations.SlideData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_data" do
    field :content_bytes, :binary
    belongs_to :slide_image, Sk.Presentations.SlideImage

    timestamps()
  end

  @doc false
  def changeset(slide_data, attrs) do
    slide_data
    |> cast(attrs, [:content_bytes])
    |> validate_required([:content_bytes])
  end
end
