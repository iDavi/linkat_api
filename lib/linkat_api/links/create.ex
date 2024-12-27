defmodule LinkatApi.Links.Create do

  alias LinkatApi.Links.Cache
  alias LinkatApi.Links.Link
  alias LinkatApi.Repo
  def call(link) do
    link
    |> Link.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert(repo_response) do
    update_cache(repo_response)
    repo_response
  end

  defp update_cache(repo_response) do
    case repo_response do
      {:ok, link} -> Cache.add_link(link)
      _ -> :error
    end
  end

end
