defmodule Sk.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string
      add :twitter_id, :string, null: false
      timestamps()
    end

    create unique_index(:speakers, [:twitter_id])
  end
end
