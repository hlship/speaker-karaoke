defmodule Sk.Repo do
  use Ecto.Repo,
    otp_app: :sk,
    adapter: Ecto.Adapters.Postgres
end
