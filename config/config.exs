# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sk,
  ecto_repos: [SK.Repo]

# Configures the endpoint
config :sk, SKWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Qni9yjdw27aQc4UvkvYAgPpnlpk0sTW0IiQpcFWsKf/I1O6Uqkmj/2lke3CbuvUQ",
  render_errors: [view: SKWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SK.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
