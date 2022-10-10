defmodule SharePlay.Playlists do
  alias SharePlay.Repo
  alias SharePlay.Playlists.Video

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
end
