defmodule Sk.MixProject do
  use Mix.Project

  def project do
    [
      app: :sk,
      version: "0.1.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Sk.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Use esbuild early, before Phoenix 1.6:
      {:phoenix, github: "phoenixframework/phoenix", branch: "v1.5", override: true},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_live_view, "~> 0.15.4"},
      {:phoenix_live_dashboard, "~> 0.4.0"},
      {:floki, ">= 0.27.0", only: :test},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:esbuild, "~> 0.1", runtime: Mix.env() == :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.1"},
      {:pbkdf2_elixir, "~> 1.0"},
      {:httpoison, "~> 1.8"},
      {:ex_image_info, "~> 0.2.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet",
             "ecto.migrate --quiet",
             "test"],
      "assets.deploy": [
        "esbuild default --minify",
        "phx.digest"
      ],
      "prod.server": [
        "assets.deploy",
        "phx.server"
      ]
    ]
  end
end
