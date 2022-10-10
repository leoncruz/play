defmodule SharePlay.Playlists.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  alias SharePlay.Playlists.Video

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
    |> validate_required([:name, :category])
  end
end
