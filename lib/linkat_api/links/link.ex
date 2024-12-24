defmodule LinkatApi.Links.Link do
  import Ecto.Changeset
  use Ecto.Schema
  @params [:nickname, :url]
  @derive {Jason.Encoder, only: @params}

  schema "links" do
    field :nickname, :string
    field :url, :string
    timestamps()
  end

  def changeset(link \\%__MODULE__{}, params) do
    link
    |> cast(params, @params)
    |> validate_required(@params)
    |> validate_length(:nickname, min: 2, max: 20)
    |> validate_format(:nickname, ~r(^[a-zA-Z0-9_-]*$))
    |> validate_url(:url)
    |> unique_constraint(:nickname, name: :links_nickname_index)
  end

  # validate_url function source: https://gist.github.com/atomkirk/74b39b5b09c7d0f21763dd55b877f998
  def validate_url(changeset, field, opts \\ []) do
    validate_change(changeset, field, fn _, value ->
      case URI.parse(value) do
        %URI{scheme: nil} ->
          "is missing a scheme (e.g. https)"

        %URI{host: nil} ->
          "is missing a host"

        %URI{host: host} ->
          case :inet.gethostbyname(Kernel.to_charlist(host)) do
            {:ok, _} -> nil
            {:error, _} -> "invalid host"
          end
      end
      |> case do
        error when is_binary(error) -> [{field, Keyword.get(opts, :message, error)}]
        _ -> []
      end
    end)
  end
end
