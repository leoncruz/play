defmodule SharePlayWeb.VideoController do
  use SharePlayWeb, :controller

  alias SharePlay.Repo
  alias SharePlay.Playlist.Video

  import Ecto.Query

  def index(conn, _params) do
    query = from(v in Video, order_by: [desc: v.updated_at])

    videos = Repo.all(query)

    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    video = Video.changeset(%Video{})

    render(conn, "new.html", video: video)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Video.changeset(%Video{}, video_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
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
    video = Repo.get(Video, video_id)

    video_changeset = Video.changeset(video)

    render(conn, "edit.html", video: video, video_changeset: video_changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Repo.get(Video, id)

    changeset = Video.changeset(video, video_params)

    case Repo.update(changeset) do
      {:ok, _} ->
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
    video = Repo.get(Video, id)

    case Repo.delete(video) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Video deleted successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:alert, "Video cannot be delted successfully.")
        |> render("index.html", conn: conn)
    end
  end
end
