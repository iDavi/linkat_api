defmodule LinkatApi.Repo.Migrations.AddLinksTable do
  use Ecto.Migration

  def change do
    create table("links") do
      add :nickname, :string, null: false
      add :url, :string, null: false
      timestamps()
    end
    create unique_index(:links, [:nickname])
  end
end
