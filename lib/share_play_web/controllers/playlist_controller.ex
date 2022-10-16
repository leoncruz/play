defmodule PlayWeb.PlaylistController do
  use PlayWeb, :controller

  alias Play.Playlists
  alias Play.Playlists.{Playlist, Video}

  def index(conn, _params) do
    playlists = Playlists.list_playlists()

    render(conn, "index.html", playlists: playlists)
  end

  def new(conn, _params) do
    playlist =
      %Playlist{videos: [%Video{}]}
      |> Playlists.playlist_changeset()

    render(conn, "new.html", playlist: playlist)
  end

  def create(conn, %{"playlist" => playlist_params}) do
    case Playlists.create_playlist(playlist_params) do
      {:ok, playlist} ->
        conn
        |> put_flash(:info, "Playlist created sucessfully.")
        |> redirect(to: Routes.playlist_path(conn, :show, playlist))

      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Playlist cannot be created.")
        |> render("new.html", playlist: changeset)
    end
  end

  def show(conn, %{"id" => playlist_id}) do
    playlist = Playlists.get_playlist(playlist_id)

    render(conn, "show.html", playlist: playlist)
  end

  def edit(conn, %{"id" => playlist_id}) do
    playlist = Playlists.get_playlist(playlist_id)

    playlist_changeset =
      playlist
      |> Playlists.playlist_changeset()

    render(conn, "edit.html", playlist: playlist, playlist_changeset: playlist_changeset)
  end

  def update(conn, %{"id" => id, "playlist" => plalist_params}) do
    case Playlists.update_playlist(id, plalist_params) do
      {:ok, playlist} ->
        conn
        |> put_flash(:info, "Playlist updated sucessfully")
        |> redirect(to: Routes.playlist_path(conn, :show, playlist))

      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Playlist cannot be updated")
        |> render("edit.html", conn: conn, plalist: changeset)
    end
  end

  def delete(conn, %{"id" => playlist_id}) do
    case Playlists.delete_playlist(playlist_id) do
      :ok ->
        conn
        |> put_flash(:info, "Playlist deleted sucessfully.")
        |> redirect(to: Routes.playlist_path(conn, :index))

      :error ->
        conn
        |> put_flash(:alert, "Playlist cannot be deteled.")
        |> render("index.html", playlists: Playlists.list_playlists())
    end
  end
end
