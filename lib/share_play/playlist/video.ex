defmodule SharePlay.Playlist.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
