# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :getwork,
  ecto_repos: [Getwork.Repo]

# Configures the endpoint
config :getwork, GetworkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SJdBYp6+3MHg2s48GGr/eaUBveqUoBN2exnW1wchlOmEbbqZR1OH8Tnf4J1D/PU4",
  render_errors: [view: GetworkWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Getwork.PubSub,
  live_view: [signing_salt: "c5sToqMb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
