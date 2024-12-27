defmodule LinkatApi.Links.Cache do
  alias LinkatApi.Repo
  alias LinkatApi.Links.Link

  use Agent

  def start_link(_) do
    Agent.start_link(
      fn -> %{} end,
      name: __MODULE__
    )
  end

  defp create_links_map(all_links) do
    new_map = %{}

    Enum.each(all_links, fn l ->
      Map.put(new_map, Map.get(l, :nickname), l)
    end)

    new_map
  end

  def get_by_nickname(nickname) do
    all_links = Agent.get(__MODULE__, & &1)

    case Map.get(all_links, nickname) do
      %Link{} = link -> link
      nil -> Repo.get_by(Link, nickname: nickname)
    end
  end

  def add_link(link) do
    Agent.update(__MODULE__, fn curr_map ->
      Map.put(curr_map, Map.get(curr_map, :nickname), link)
    end)
  end

  def all do
    Agent.get(__MODULE__, & &1)
  end

  def update_all do
    Agent.update(__MODULE__, fn _ ->
      Repo.all(Link) |> create_links_map()
    end)
  end
end
