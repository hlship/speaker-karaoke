defmodule Sk.SlideShowTest do
  use Sk.DataCase

  alias Sk.SlideShow

  describe "slide_images" do
    alias Sk.SlideShow.SlideImage

    @valid_attrs %{content_type: "some content_type", source_url: "some source_url"}
    @update_attrs %{content_type: "some updated content_type", source_url: "some updated source_url"}
    @invalid_attrs %{content_type: nil, source_url: nil}

    def slide_image_fixture(attrs \\ %{}) do
      {:ok, slide_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SlideShow.create_slide_image()

      slide_image
    end

    test "list_slide_images/0 returns all slide_images" do
      slide_image = slide_image_fixture()
      assert SlideShow.list_slide_images() == [slide_image]
    end

    test "get_slide_image!/1 returns the slide_image with given id" do
      slide_image = slide_image_fixture()
      assert SlideShow.get_slide_image!(slide_image.id) == slide_image
    end

    test "create_slide_image/1 with valid data creates a slide_image" do
      assert {:ok, %SlideImage{} = slide_image} = SlideShow.create_slide_image(@valid_attrs)
      assert slide_image.content_type == "some content_type"
      assert slide_image.source_url == "some source_url"
    end

    test "create_slide_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SlideShow.create_slide_image(@invalid_attrs)
    end

    test "update_slide_image/2 with valid data updates the slide_image" do
      slide_image = slide_image_fixture()
      assert {:ok, %SlideImage{} = slide_image} = SlideShow.update_slide_image(slide_image, @update_attrs)
      assert slide_image.content_type == "some updated content_type"
      assert slide_image.source_url == "some updated source_url"
    end

    test "update_slide_image/2 with invalid data returns error changeset" do
      slide_image = slide_image_fixture()
      assert {:error, %Ecto.Changeset{}} = SlideShow.update_slide_image(slide_image, @invalid_attrs)
      assert slide_image == SlideShow.get_slide_image!(slide_image.id)
    end

    test "delete_slide_image/1 deletes the slide_image" do
      slide_image = slide_image_fixture()
      assert {:ok, %SlideImage{}} = SlideShow.delete_slide_image(slide_image)
      assert_raise Ecto.NoResultsError, fn -> SlideShow.get_slide_image!(slide_image.id) end
    end

    test "change_slide_image/1 returns a slide_image changeset" do
      slide_image = slide_image_fixture()
      assert %Ecto.Changeset{} = SlideShow.change_slide_image(slide_image)
    end
  end
end
