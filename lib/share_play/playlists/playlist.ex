defmodule Play.Playlists.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  alias Play.Playlists.Video

  schema "playlists" do
    field :category, :string
    field :name, :string
    has_many(:videos, Video)

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs \\ %{}) do
    playlist
    |> cast(attrs, [:name, :category])
    |> cast_assoc(:videos, required: true, with: &Video.playlist_video_changeset/2)
    |> validate_required([:name, :category])
  end
end
