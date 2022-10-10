defmodule SharePlayWeb.VideoController do
  use SharePlayWeb, :controller

  alias SharePlay.Playlists
  alias SharePlay.Playlists.Video

  def index(conn, _params) do
    videos = Playlists.list_videos()

    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    video = Playlists.video_changeset(%Video{})

    render(conn, "new.html", video: video)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Playlists.video_changeset(%Video{}, video_params)

    case Playlists.create_video(changeset) do
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
    video = Playlists.get_video(video_id)

    video_changeset = Playlists.video_changeset(video)

    render(conn, "edit.html", video: video, video_changeset: video_changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Playlists.get_video(id)

    changeset = Playlists.video_changeset(video, video_params)

    case Playlists.update_video(changeset) do
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
    case Playlists.delete_video(id) do
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
