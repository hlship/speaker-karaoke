defmodule Sk.SlideDecks.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_images" do
    # Storing the content itself in the DB is a temporary measure; we'll ultimately use some kind of block storage
    # and also support multiple versions of the same file (thumbnail vs. original vs. full size, etc.)
    field :content, :binary
    field :content_type, :string

    # Track the user who initially submitted the image
    belongs_to :submitted_by, Sk.Accounts.User, foreign_key: :submitter_id

    timestamps()
  end

  @doc false
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:content, :content_type, :submitter_id])
    |> validate_required([:content, :content_type, :submitter_id])
  end
end
