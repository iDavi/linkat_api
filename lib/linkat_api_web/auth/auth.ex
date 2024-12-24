defmodule LinkatApiWeb.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    request_token = get_authorization_header(conn)
    required_token = Application.get_env(:linkat_api, LinkatApiWeb.Auth)[:authenticationToken]
    IO.inspect(required_token)
    if request_token == required_token do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> Phoenix.Controller.json(%{success: false, message: "Not authenticated"})
      |> halt()
    end
  end

  defp get_authorization_header(conn) do
    case get_req_header(conn, "authorization") do
      [auth_header] -> auth_header
      _ -> ""
    end
  end
end
