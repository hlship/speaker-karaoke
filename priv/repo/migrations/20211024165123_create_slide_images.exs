defmodule Sk.Repo.Migrations.CreateSlideImages do
  use Ecto.Migration

  def change do
    create table(:slide_images) do
      add :content, :binary
      add :content_type, :string
      add :submitter_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:slide_images, [:submitter_id])
  end
end
