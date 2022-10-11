defmodule SharePlay.Playlists.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias SharePlay.Playlists.Playlist

  schema "videos" do
    field :name, :string
    field :url, :string
    belongs_to :playlist, Playlist

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:name, :url, :playlist_id])
    |> validate_required([:name, :url, :playlist_id])
  end
end
