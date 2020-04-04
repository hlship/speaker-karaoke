defmodule Sk.Repo.Migrations.CreateSlideDecks do
  use Ecto.Migration

  def change do
    create table(:slide_decks) do
      add :title, :string
      add :presenter_id, references(:speakers, on_delete: :nothing)

      timestamps()
    end

    create index(:slide_decks, [:presenter_id])
  end
end
