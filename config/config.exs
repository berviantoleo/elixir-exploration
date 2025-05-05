# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elixir_exploration,
  ecto_repos: [ElixirExploration.Repo]

# Configures the endpoint
config :elixir_exploration, ElixirExplorationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WcOUlk1jGxImXBaJvnmFxtXe8NSPK558P0il2ytnIoIDrT3KHVLQ/BoM6t4HLHFE",
  render_errors: [view: ElixirExplorationWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirExploration.PubSub,
  live_view: [signing_salt: "6Juvb0Rz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_aws,
  region: {:system, "AWS_DEFAULT_REGION"}

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
