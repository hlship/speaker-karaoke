defmodule Sk.Repo.Migrations.AddSlideDataKind do
  use Ecto.Migration

  def change do
    alter table(:slide_data) do
      add :kind, :string, null: false
    end
    create index(:slide_data, [:slide_image_id, :kind])
  end
end
