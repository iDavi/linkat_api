defmodule LinkatApi.Links.Get do


  alias LinkatApi.Links.Cache

  def call(nickname) do
    case Cache.get_by_nickname(nickname) do
      nil -> {:error, :not_found}
      link -> handle_success(link)
    end
  end

  def handle_success(link) do
    Cache.add_link(link)
    {:ok, link}
  end


end
