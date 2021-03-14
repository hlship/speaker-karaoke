defmodule Sk.Repo.Migrations.AddSlideDeckContentType do
  use Ecto.Migration

  def change do
    alter table(:slide_data) do
      add :content_type, :string, null: false
    end
  end
end
