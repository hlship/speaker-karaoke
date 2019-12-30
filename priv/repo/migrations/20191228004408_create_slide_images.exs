defmodule Sk.Repo.Migrations.CreateSlideImages do
  use Ecto.Migration

  def change do
    create table(:slide_images) do
      add :source_url, :string
      add :content_type, :string
      add :submitted_by, references(:speakers, on_delete: :nothing)
      add :approved_by, references(:speakers, on_delete: :nothing)

      timestamps()
    end

    create index(:slide_images, [:submitted_by])
    create index(:slide_images, [:approved_by])
  end
end
