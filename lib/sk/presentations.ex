defmodule Sk.Presentations do
  @moduledoc """
  Context for presentations: SlideImage, SlideDesk, etc.
  """

  import Ecto.Query, warn: false
  alias Sk.Repo

  alias Sk.Presentations.SlideImage
  alias Sk.Accounts.Speaker
  alias Sk.Presentations.SlideDeck

## Generic access functions that work across all SlideImages, which
## we don't use, because these are owned (submitted_by) a Speaker.

  @doc """
  Returns the list of slide_images.

  ## Examples

      iex> list_slide_images()
      [%SlideImage{}, ...]

  """
  def list_slide_images do
    Repo.all(SlideImage)
  end

  @doc """
  Gets a single slide_image.

  Raises `Ecto.NoResultsError` if the Slide image does not exist.

  ## Examples

      iex> get_slide_image!(123)
      %SlideImage{}

      iex> get_slide_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slide_image!(id), do: Repo.get!(SlideImage, id)

  @doc """
  Creates a slide_image.

  """
  def create_slide_image(%Speaker{} = speaker, attrs \\ %{}) do
    %SlideImage{}
    |> SlideImage.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:submitted_by, speaker)
    |> Repo.insert()
  end

  @doc """
  Updates a slide_image.

  ## Examples

      iex> update_slide_image(slide_image, %{field: new_value})
      {:ok, %SlideImage{}}

      iex> update_slide_image(slide_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slide_image(%SlideImage{} = slide_image, attrs) do
    slide_image
    |> SlideImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a slide_image.

  ## Examples

      iex> delete_slide_image(slide_image)
      {:ok, %SlideImage{}}

      iex> delete_slide_image(slide_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slide_image(%SlideImage{} = slide_image) do
    Repo.delete(slide_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slide_image changes.

  ## Examples

      iex> change_slide_image(slide_image)
      %Ecto.Changeset{source: %SlideImage{}}

  """
  def change_slide_image(%SlideImage{} = slide_image) do
    SlideImage.changeset(slide_image, %{})
  end


  def list_slide_images_submitted_by(%Speaker{} = speaker) do
    SlideImage
    |> submitted_by_query(speaker)
    |> Repo.all()
  end

  def get_slide_image_submitted_by!(%Speaker{} = speaker, id) do
    SlideImage
    |> submitted_by_query(speaker)
    |> Repo.get!(id)
  end


  defp submitted_by_query(query, %Speaker{id: speaker_id}) do
    from(v in query, where: v.submitted_by_id == ^speaker_id)
  end

  @doc """
  Returns the list of slide_decks.

  ## Examples

      iex> list_slide_decks()
      [%SlideDeck{}, ...]

  """
  def list_slide_decks do
    Repo.all(SlideDeck)
  end

  def list_slide_decks_presented_by(%Speaker{} = speaker) do
    SlideDeck
    |> presented_by_query(speaker)
    |> Repo.all()
  end

  defp presented_by_query(%Speaker{id: speaker_id}) do
    from(v in query, where v.presenter_id = ^speaker_id)
  end

  @doc """
  Gets a single slide_deck.

  Raises `Ecto.NoResultsError` if the Slide deck does not exist.

  ## Examples

      iex> get_slide_deck!(123)
      %SlideDeck{}

      iex> get_slide_deck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slide_deck!(id), do: Repo.get!(SlideDeck, id)

  def get_slide_deck_presented_by!(%Speaker{} = speaker, id) do
    SlideDeck
    |> presented_by_query(speaker)
    |> Repo.get!(id)
  end

  @doc """
  Creates a slide_deck.

  """
  def create_slide_deck(%Speaker{} = speaker, attrs \\ %{}) do
    %SlideDeck{}
    |> SlideDeck.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:presenter, speaker)
    |> Repo.insert()
  end

  @doc """
  Updates a slide_deck.

  ## Examples

      iex> update_slide_deck(slide_deck, %{field: new_value})
      {:ok, %SlideDeck{}}

      iex> update_slide_deck(slide_deck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slide_deck(%SlideDeck{} = slide_deck, attrs) do
    slide_deck
    |> SlideDeck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a slide_deck.

  ## Examples

      iex> delete_slide_deck(slide_deck)
      {:ok, %SlideDeck{}}

      iex> delete_slide_deck(slide_deck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slide_deck(%SlideDeck{} = slide_deck) do
    Repo.delete(slide_deck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slide_deck changes.

  ## Examples

      iex> change_slide_deck(slide_deck)
      %Ecto.Changeset{source: %SlideDeck{}}

  """
  def change_slide_deck(%SlideDeck{} = slide_deck) do
    SlideDeck.changeset(slide_deck, %{})
  end
end
