defmodule Sk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Phoenix.PubSub, name: SkWeb.PubSub},
      # Start the Ecto repository
      Sk.Repo,
      # Start the endpoint when the application starts
      SkWeb.Endpoint
      # Starts a worker by calling: Sk.Worker.start_link(arg)
      # {Sk.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
