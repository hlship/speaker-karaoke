defmodule Sk.Presentations.SlideImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slide_images" do
    field :source_url, :string
    belongs_to :submitted_by, Sk.Accounts.Speaker

    timestamps()
  end

  @doc false
  def changeset(slide_image, attrs) do
    slide_image
    |> cast(attrs, [:source_url])
    |> validate_required([:source_url])
  end
end
