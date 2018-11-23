use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :sk, SKWeb.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :sk, SK.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "skrole",
  password: System.get_env("SKROLE_PASSWORD"),
  database: "speakerkaraoke_prod",
  pool_size: 15
