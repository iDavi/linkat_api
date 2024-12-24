defmodule LinkatApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LinkatApiWeb.Telemetry,
      LinkatApi.Repo,
      {DNSCluster, query: Application.get_env(:linkat_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LinkatApi.PubSub},
      # Start a worker by calling: LinkatApi.Worker.start_link(arg)
      # {LinkatApi.Worker, arg},
      # Start to serve requests, typically the last entry
      LinkatApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LinkatApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LinkatApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
