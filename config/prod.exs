import Config


config :linkat_api, LinkatApi.Repo,
  url: System.get_env("DATABASE_URL"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :linkat_api, LinkatApiWeb.Endpoint,
  url: [
    host: System.get_env("HOST"),
    port: System.get_env("PORT"),
    scheme: "https"
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  https: [
    port: String.to_integer(System.get_env("HTTPS_PORT") || "4043"),
    cipher_suite: :strong
  ]

config :logger,
  backends: [:console],
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]
