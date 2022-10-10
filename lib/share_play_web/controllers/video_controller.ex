defmodule SharePlayWeb.VideoController do
  use SharePlayWeb, :controller

  alias SharePlay.Playlist
  alias SharePlay.Playlist.Video

  def index(conn, _params) do
    videos = Playlist.list_videos()

    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    video = Playlist.video_changeset(%Video{})

    render(conn, "new.html", video: video)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Playlist.video_changeset(%Video{}, video_params)

    case Playlist.create_video(changeset) do
      :ok ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:alert, "Video cannot be created.")
        |> render("new.html", video: changeset)
    end
  end

  def edit(conn, %{"id" => video_id}) do
    video = Playlist.get_video(video_id)

    video_changeset = Playlist.video_changeset(video)

    render(conn, "edit.html", video: video, video_changeset: video_changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Playlist.get_video(id)

    changeset = Playlist.video_changeset(video, video_params)

    case Playlist.update_video(changeset) do
      :ok ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:alert, "Video cannot be updated.")
        |> render("edit.html", video: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Playlist.delete_video(id) do
      :ok ->
        conn
        |> put_flash(:info, "Video deleted successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      :error ->
        conn
        |> put_flash(:alert, "Video cannot be delted successfully.")
        |> render("index.html", conn: conn)
    end
  end
end
