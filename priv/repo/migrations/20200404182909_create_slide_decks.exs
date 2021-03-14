defmodule Sk.Repo.Migrations.CreateSlideDecks do
  use Ecto.Migration

  def change do
    create table(:slide_decks) do
      add :title, :string, null: false
      add :presenter_id, references(:speakers, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:slide_decks, [:presenter_id])
  end
end
