defmodule Sk.Repo.Migrations.SlideImageComment do
  use Ecto.Migration

  def change do
    alter table(:slide_images) do
      add :comment, :string
      modify :source_url, :string, null: false, default: ""
    end
    create unique_index(:slide_images, [:source_url])
  end
end
