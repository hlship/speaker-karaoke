defmodule Sk.Repo.Migrations.PasswordHash do
  use Ecto.Migration

  def change do
    alter table(:speakers) do
      add :password_hash, :string, null: false
    end
  end
end
