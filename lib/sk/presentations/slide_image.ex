defmodule Sk.Presentations.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sk.Accounts.Speaker
  alias Sk.Presentations.SlideData

  schema "slide_images" do
    # URL from which the image was obtained, or null if directly uploaded
    field :source_url, :string
    # Optional comment, perhaps for further attribution
    field :comment, :string
    # The speaker, if any, that submitted the slide image
    # (it may come in from other means than speaker submissions).
    belongs_to :submitted_by, Speaker
    # Slide Data in various widths and heights; eventually we'll have
    # an original, and others generated via ImageMagick.
    has_many :slide_data, SlideData

    timestamps()
  end

  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:source_url, :comment])
  end
end
