defmodule Play.Repo.Migrations.AddPlaylistIdToVideo do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add(:playlist_id, references(:playlists, on_delete: :delete_all), null: false)
    end
  end
end
