defmodule LinkatApi.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    [request_token] = get_req_header(conn, "authorization")
    required_token = Application.get_env(:linkat_api, LinkatApiWeb.Endpoint)[:authenticationToken]
    if request_token == required_token do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> Phoenix.Controller.json(%{success: false, message: "Not authenticated"})
      |> halt()
    end
  end
end
