defmodule Sk.Presentations.SlideData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_data" do
    # I understand that best practices are keep binary fields in their own table with nothing but a PK.
    field :content_bytes, :binary
    belongs_to :slide_image, Sk.Presentations.SlideImage
    field :kind, :string, null: false
    timestamps()
  end

  @doc false
  def changeset(slide_data, attrs) do
    slide_data
    |> cast(attrs, [:content_bytes])
    |> validate_required([:content_bytes, :kind])
  end
end
