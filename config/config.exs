# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bookmarks,
  ecto_repos: [Bookmarks.Repo]

# Configures the endpoint
config :bookmarks, Bookmarks.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Az09goAeTHSMW3xuGPMQ5AQw53rLHcCfVxTSUG03Uhyw5BnD8bPM1yiRuRsVl5Qq",
  render_errors: [view: Bookmarks.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bookmarks.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
