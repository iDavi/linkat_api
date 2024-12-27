# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :linkat_api,
  ecto_repos: [LinkatApi.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :linkat_api, LinkatApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: LinkatApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LinkatApi.PubSub,
  live_view: [signing_salt: "1unhSCiA"]



# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :my_app, MyApp.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :linkat_api, LinkatApiWeb.Plugs.Captcha,
  secret: System.get_env("RECAPTCHA_SECRET_KEY_LINKAT")

config :payments_client, RateLimiter,
  rate_limiter: PaymentsClient.RateLimiters.LeakyBucket,
  timeframe_max_requests: 60,
  timeframe_units: :seconds,
  timeframe: 60


config :tesla, adapter: Tesla.Adapter.Mint
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
