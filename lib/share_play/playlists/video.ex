defmodule SharePlay.Playlists.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias SharePlay.Playlists.Playlist

  schema "videos" do
    field :name, :string
    field :url, :string
    belongs_to :playlist, Playlist
    field :delete, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:name, :url, :playlist_id])
    |> validate_required([:name, :url, :playlist_id])
  end

  @doc false
  def playlist_video_changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:name, :url, :delete])
    |> validate_required([:name, :url])
    |> mark_for_deletion()
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
