defmodule Sk.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string, null: false
      add :speaker_id, :string, null: false
      timestamps()
    end

    create unique_index(:speakers, [:speaker_id])
  end
end
