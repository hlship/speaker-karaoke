defmodule Sk.SlideShow do
  @moduledoc """
  The SlideShow context.
  """

  import Ecto.Query, warn: false
  alias Sk.Repo

  alias Sk.SlideShow.SlideImage

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

  ## Examples

      iex> create_slide_image(%{field: value})
      {:ok, %SlideImage{}}

      iex> create_slide_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slide_image(attrs \\ %{}) do
    %SlideImage{}
    |> SlideImage.changeset(attrs)
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
  Deletes a SlideImage.

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
end
