defmodule Sk.Presentations.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_images" do
    field :source_url, :string, null: false
    # Optional comment, perhaps for further attribution
    field :comment, :string
    # The speaker, if any, that submitted the slide image
    # (it may come in from other means than speaker submissions).
    belongs_to :submitted_by, Sk.Accounts.Speaker
    # Slide Data in various widths and heights; eventually we'll have
    # an original, and others generated via ImageMagick.
    has_many :slide_data, Sk.Presentations.SlideData

    timestamps()
  end

  @doc false
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:source_url, :comment])
    |> validate_required([:source_url])
  end
end
