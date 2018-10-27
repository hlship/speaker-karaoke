defmodule Sk.Repo.Migrations.CreateDailyMessages do
  use Ecto.Migration

  def change do
    create table(:daily_messages) do
      add :message_text, :text
      add :expires_at, :naive_datetime, null: true

      timestamps()
    end

  end
end
