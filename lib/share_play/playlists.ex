defmodule SharePlay.Playlists do
  alias SharePlay.Repo
  alias SharePlay.Playlists.{Video, Playlist}

  import Ecto.Query

  def list_videos do
    query = from(v in Video, order_by: [desc: v.updated_at])

    Repo.all(query)
  end

  def video_changeset(video, params \\ %{}) do
    Video.changeset(video, params)
  end

  def create_video(changeset) do
    case Repo.insert(changeset) do
      {:ok, _} -> :ok
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  def get_video(id) do
    Repo.get(Video, id)
  end

  def update_video(changeset) do
    case Repo.update(changeset) do
      {:ok, _} -> :ok
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  def delete_video(id) do
    video = get_video(id)

    case Repo.delete(video) do
      {:ok, _} -> :ok
      {:error, _} -> :error
    end
  end

  def list_playlists do
    query = from(p in Playlist, order_by: [desc: p.updated_at])

    Repo.all(query)
  end

  def playlist_changeset(playlist, attrs \\ %{}) do
    Playlist.changeset(playlist, attrs)
  end

  def create_playlist(attrs) do
    %Playlist{}
    |> Playlist.changeset(attrs)
    |> Repo.insert()
  end

  def get_playlist(id) do
    Repo.get(Playlist, id)
    |> Repo.preload(:videos)
  end

  def update_playlist(id, params) do
    Repo.get(Playlist, id)
    |> Repo.preload(:videos)
    |> playlist_changeset(params)
    |> Repo.update()
  end

  def delete_playlist(id) do
    playlist = get_playlist(id)

    case Repo.delete(playlist) do
      {:ok, _} -> :ok
      {:error, _} -> :error
    end
  end
end
