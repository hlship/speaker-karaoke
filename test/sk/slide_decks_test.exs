defmodule Sk.SlideDecksTest do
  use Sk.DataCase

  alias Sk.SlideDecks

  describe "slide_images" do
    alias Sk.SlideDecks.SlideImage

    import Sk.SlideDecksFixtures

    @invalid_attrs %{content: nil, content_type: nil}

    test "list_slide_images/0 returns all slide_images" do
      slide_image = slide_image_fixture()
      assert SlideDecks.list_slide_images() == [slide_image]
    end

    test "get_slide_image!/1 returns the slide_image with given id" do
      slide_image = slide_image_fixture()
      assert SlideDecks.get_slide_image!(slide_image.id) == slide_image
    end

    test "create_slide_image/1 with valid data creates a slide_image" do
      valid_attrs = %{content: "some content", content_type: "some content_type"}

      assert {:ok, %SlideImage{} = slide_image} = SlideDecks.create_slide_image(valid_attrs)
      assert slide_image.content == "some content"
      assert slide_image.content_type == "some content_type"
    end

    test "create_slide_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SlideDecks.create_slide_image(@invalid_attrs)
    end

    test "update_slide_image/2 with valid data updates the slide_image" do
      slide_image = slide_image_fixture()
      update_attrs = %{content: "some updated content", content_type: "some updated content_type"}

      assert {:ok, %SlideImage{} = slide_image} = SlideDecks.update_slide_image(slide_image, update_attrs)
      assert slide_image.content == "some updated content"
      assert slide_image.content_type == "some updated content_type"
    end

    test "update_slide_image/2 with invalid data returns error changeset" do
      slide_image = slide_image_fixture()
      assert {:error, %Ecto.Changeset{}} = SlideDecks.update_slide_image(slide_image, @invalid_attrs)
      assert slide_image == SlideDecks.get_slide_image!(slide_image.id)
    end

    test "delete_slide_image/1 deletes the slide_image" do
      slide_image = slide_image_fixture()
      assert {:ok, %SlideImage{}} = SlideDecks.delete_slide_image(slide_image)
      assert_raise Ecto.NoResultsError, fn -> SlideDecks.get_slide_image!(slide_image.id) end
    end

    test "change_slide_image/1 returns a slide_image changeset" do
      slide_image = slide_image_fixture()
      assert %Ecto.Changeset{} = SlideDecks.change_slide_image(slide_image)
    end
  end
end
