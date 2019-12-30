defmodule Sk.SlideShow.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_images" do
    field :content_type, :string
    field :source_url, :string
    field :submitted_by, :id
    field :approved_by, :id

    timestamps()
  end

  @doc false
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:source_url, :content_type])
    |> validate_required([:source_url, :content_type])
  end
end
