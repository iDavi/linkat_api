defmodule LinkatApiWeb.LinksController do
  use LinkatApiWeb, :controller
  plug LinkatApiWeb.Plugs.Captcha when action in [:create]

  alias LinkatApi.Links
  alias Links.Link

  action_fallback LinkatApiWeb.FallbackController
  def create(conn, params) do
    with{:ok, %Link{} = link} <- Links.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, link: link)
    end

  end

  def show(conn, %{"nickname" => nickname}) do
    with{:ok, %Link{} = link} <- Links.get(nickname) do
      conn
      |> put_status(:ok)
      |> render(:get, link: link)
    end
  end
end
