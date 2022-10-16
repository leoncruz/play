defmodule PlayWeb.VideoController do
  use PlayWeb, :controller

  alias Play.Playlists
  alias Play.Playlists.Video
  alias Play.Repo

  def index(conn, _params) do
    videos = Playlists.list_videos()

    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    video =
      %Video{}
      |> Repo.preload(:playlist)
      |> Playlists.video_changeset()

    playlists = Playlists.list_playlists()

    render(conn, "new.html", video: video, playlists: playlists)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Playlists.video_changeset(%Video{}, video_params)

    playlists = Playlists.list_playlists()

    case Playlists.create_video(changeset) do
      :ok ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:alert, "Video cannot be created.")
        |> render("new.html", video: changeset, playlists: playlists)
    end
  end

  def edit(conn, %{"id" => video_id}) do
    video = Playlists.get_video(video_id)

    video_changeset =
      video
      |> Repo.preload(:playlist)
      |> Playlists.video_changeset()

    playlists = Playlists.list_playlists()

    render(
      conn,
      "edit.html",
      video: video,
      video_changeset: video_changeset,
      playlists: playlists
    )
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
