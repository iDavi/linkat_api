defmodule LinkatApi.Links do

  alias LinkatApi.Repo
  alias LinkatApi.Links.Link
  alias LinkatApi.Links.Cache


  @spec create(map()) :: {:ok, map()} | {:error, Ecto.Changeset.t()}
  def create(link) do
    case link |> Link.changeset() |> Repo.insert() do
        {:ok, link} -> Cache.add_link(link)
        e -> e
    end
  end

  @spec get(map()) :: {:ok, map()}
  def get(nickname) do
    case Cache.get_by_nickname(nickname) do
      nil -> {:error, :not_found}
      link ->  Cache.add_link(link)
    end
  end

end
