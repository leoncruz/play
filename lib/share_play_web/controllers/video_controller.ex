defmodule SharePlayWeb.VideoController do
  use SharePlayWeb, :controller

  alias SharePlay.Repo
  alias SharePlay.Playlist.Video

  def index(conn, _params) do
    videos = Repo.all(Video)

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
        render(conn, "new.html", video: changeset)
    end
  end
end
