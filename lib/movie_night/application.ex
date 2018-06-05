defmodule MovieNight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      MovieNight.Repo,
      # Start the endpoint when the application starts
      MovieNightWeb.Endpoint,
      # Starts a worker by calling: MovieNight.Worker.start_link(arg)
      # {MovieNight.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MovieNight.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MovieNightWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
