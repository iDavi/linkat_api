defmodule LinkatApi.Links do
  alias LinkatApi.Links
  defdelegate create(params), to: Links.Create, as: :call
  defdelegate get(nickname), to: Links.Get, as: :call
end
