defmodule Sk.SlideDecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sk.SlideDecks` context.
  """

  @doc """
  Generate a slide_image.
  """
  def slide_image_fixture(attrs \\ %{}) do
    {:ok, slide_image} =
      attrs
      |> Enum.into(%{
        content: "some content",
        content_type: "some content_type"
      })
      |> Sk.SlideDecks.create_slide_image()

    slide_image
  end
end
