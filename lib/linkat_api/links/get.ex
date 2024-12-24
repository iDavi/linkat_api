defmodule LinkatApi.Links.Get do


  alias LinkatApi.Repo
  alias LinkatApi.Links.Link

  def call(nickname) do
    case Repo.get_by(Link, nickname: nickname) do
      nil -> {:error, :not_found}
      link -> {:ok, link}
    end
  end


end
