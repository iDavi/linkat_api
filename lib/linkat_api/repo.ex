defmodule LinkatApi.Repo do
  use Ecto.Repo,
    otp_app: :linkat_api,
    adapter: Ecto.Adapters.Postgres
end
