defmodule Sk.Repo.Migrations.CreateSlideData do
  use Ecto.Migration

  def change do
    create table(:slide_data) do
      add :content_bytes, :binary
      add :slide_image_id, references(:slide_images, on_delete: :nothing)

      timestamps()
    end

    create index(:slide_data, [:slide_image_id])
  end
end
