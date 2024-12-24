defmodule LinkatApiWeb.FallbackController do
  use LinkatApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |>put_status(:bad_request)
    |>put_view(json: LinkatApiWeb.ErrorJSON)
    |>render(:error, changeset: changeset)
  end

  def call(conn, {:error, status}) do
    conn
    |>put_status(:bad_request)
    |>put_view(json: LinkatApiWeb.ErrorJSON)
    |>render(:error, status: status)
  end


end
