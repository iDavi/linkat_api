defmodule LinkatApi.Links.Create do

  alias LinkatApi.Repo
  alias LinkatApi.Links.Link

  def call(link) do
    link
    |> Link.changeset()
    |> Repo.insert()
  end


end
