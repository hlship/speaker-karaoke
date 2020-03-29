defmodule Sk.PresentationsTest do
  use Sk.DataCase

  alias Sk.Presentations

  describe "slide_images" do
    alias Sk.Presentations.SlideImage

    @valid_attrs %{source_url: "some source_url"}
    @update_attrs %{source_url: "some updated source_url"}
    @invalid_attrs %{source_url: nil}

    def slide_image_fixture(attrs \\ %{}) do
      {:ok, slide_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Presentations.create_slide_image()

      slide_image
    end

    test "list_slide_images/0 returns all slide_images" do
      slide_image = slide_image_fixture()
      assert Presentations.list_slide_images() == [slide_image]
    end

    test "get_slide_image!/1 returns the slide_image with given id" do
      slide_image = slide_image_fixture()
      assert Presentations.get_slide_image!(slide_image.id) == slide_image
    end

    test "create_slide_image/1 with valid data creates a slide_image" do
      assert {:ok, %SlideImage{} = slide_image} = Presentations.create_slide_image(@valid_attrs)
      assert slide_image.source_url == "some source_url"
    end

    test "create_slide_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Presentations.create_slide_image(@invalid_attrs)
    end

    test "update_slide_image/2 with valid data updates the slide_image" do
      slide_image = slide_image_fixture()
      assert {:ok, %SlideImage{} = slide_image} = Presentations.update_slide_image(slide_image, @update_attrs)
      assert slide_image.source_url == "some updated source_url"
    end

    test "update_slide_image/2 with invalid data returns error changeset" do
      slide_image = slide_image_fixture()
      assert {:error, %Ecto.Changeset{}} = Presentations.update_slide_image(slide_image, @invalid_attrs)
      assert slide_image == Presentations.get_slide_image!(slide_image.id)
    end

    test "delete_slide_image/1 deletes the slide_image" do
      slide_image = slide_image_fixture()
      assert {:ok, %SlideImage{}} = Presentations.delete_slide_image(slide_image)
      assert_raise Ecto.NoResultsError, fn -> Presentations.get_slide_image!(slide_image.id) end
    end

    test "change_slide_image/1 returns a slide_image changeset" do
      slide_image = slide_image_fixture()
      assert %Ecto.Changeset{} = Presentations.change_slide_image(slide_image)
    end
  end
end
