defmodule Sk.Repo.Migrations.SlideImageComment do
  use Ecto.Migration

  def change do
    alter table(:slide_images) do
      add :comment, :string
    end
    create unique_index(:slide_images, [:source_url])
  end
end
