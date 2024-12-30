import Config


config :linkat_api, LinkatApi.Repo,
  url: System.get_env("DATABASE_URL"),
  username: "postgres",
  database: "linkat_db",
  stacktrace: true,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :linkat_api, LinkatApiWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  allow_cors: ["https://linkat.fun", "https://www.linkat.fun"]

config :logger,
  backends: [:console],
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]
