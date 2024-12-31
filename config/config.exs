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
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: LinkatApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LinkatApi.PubSub



# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]



# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :linkat_api, LinkatApiWeb.Plugs.Captcha,
  secret: System.get_env("RECAPTCHA_SECRET_KEY_LINKAT")



config :tesla, adapter: Tesla.Adapter.Mint
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
