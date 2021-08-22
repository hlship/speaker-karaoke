defmodule Sk.Presentations.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sk.Accounts.Speaker
  alias Sk.Presentations.SlideData
  alias Sk.Presentations.ImageDownload

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


  # Default changeset for inserting a new slide image.
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:source_url, :comment])
    |> validate_required([:source_url])
  end

  def load_full_image_data(changeset) do
    {:ok, _width, _height, mime_type, image_data} = ImageDownload.download(changeset.changes.source_url)
    # TODO: Handle errors!
    slide_data = %SlideData{
      kind: "original",
      content_type: mime_type,
      content_bytes: image_data}
    put_assoc(changeset, :slide_data, [slide_data])
  end
end
