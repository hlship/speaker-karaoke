defmodule Sk.Repo.Migrations.CreateSlideImages do
  use Ecto.Migration

  def change do
    create table(:slide_images) do
      add :source_url, :string, null: false
      add :submitted_by_id, references(:speakers, on_delete: :nothing)

      timestamps()
    end

    create index(:slide_images, [:submitted_by_id])
  end
end
