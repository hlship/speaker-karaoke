defmodule Sk.Accounts.Speaker do

  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :name, :string
    field :twitter_id, :string
    timestamps()
  end

end
