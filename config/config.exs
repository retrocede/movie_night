# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :movie_night,
  ecto_repos: [MovieNight.Repo]

# Configures the endpoint
config :movie_night, MovieNightWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RbxGSND28UIS2On7YsgWUidy9pu4d4C8sgvRHm5n2ie8r0l3CVRv4iaakhjxCliS",
  render_errors: [view: MovieNightWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MovieNight.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
