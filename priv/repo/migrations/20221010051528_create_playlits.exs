defmodule Play.Repo.Migrations.CreatePlaylits do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add(:name, :string, null: false)
      add(:category, :string, null: false)

      timestamps()
    end
  end
end
