defmodule Sk.Accounts.Speaker do
  @moduledoc """
  A Speaker in Speaker-Karaoke is the effectively a User.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :name, :string
    field :speaker_id, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps()
  end

  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :speaker_id])
    |> validate_required([:name, :speaker_id])
    |> validate_length(:name, min: 1, max: 50)
    |> unique_constraint(:speaker_id)
  end

  def registration_changeset(speaker, params) do
    speaker
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ -> changeset
    end
  end

end
