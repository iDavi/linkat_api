defmodule LinkatApiWeb.Plugs.Captcha do
  use Tesla

  import Plug.Conn
  import Phoenix.Controller
  alias Tesla.Middleware.BaseUrl
  alias Tesla.Middleware.Headers

  @client Tesla.client([
            {BaseUrl, "https://www.google.com/recaptcha/api"},
            {Headers, [{"Content-Type", "application/x-www-form-urlencoded"}]},
            {Tesla.Middleware.FormUrlencoded,
             encode: &Plug.Conn.Query.encode/1, decode: &Plug.Conn.Query.decode/1},
            {Tesla.Middleware.JSON, encode: &Jason.encode/1, decode: &Jason.decode/1}
          ])

  @recaptcha_secret_key Application.compile_env(:linkat_api, LinkatApiWeb.Plugs.Captcha)[:secret]

  def init(config), do: config

  def call(conn, _config) do
    case verify_recaptcha(conn) do
      :ok ->
        conn

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          success: false,
          errors: ["Bip bup, bup bip? Invalid anti-robot challenge. Please try again!"]
        })
        |> halt()
    end
  end

  defp verify_recaptcha(conn) do
    response = conn.body_params["recaptcha"]

    req_body = %{
      secret: @recaptcha_secret_key,
      response: response
    }

    case Tesla.post(@client, "/siteverify", req_body) do
      {:ok, %Tesla.Env{status: 200, body: %{"success" => true}}} -> :ok
      _ -> :error
    end
  end
end
