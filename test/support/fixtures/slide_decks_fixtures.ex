defmodule Sk.SlideDecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sk.SlideDecks` context.
  """

  import Sk.AccountsFixtures

  @doc """
  Generate a slide_image.
  """
  def slide_image_fixture(attrs \\ %{}) do
    {:ok, slide_image} =
      attrs
      |> Enum.into(%{
        content: "some content",
        content_type: "some content_type",
        # TODO: Only create if no submitter_id supplied in attrs
        submitter_id: user_fixture().id
      })
      |> Sk.SlideDecks.create_slide_image()

    slide_image
  end
end
