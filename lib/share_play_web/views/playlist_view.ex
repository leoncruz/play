defmodule SharePlayWeb.PlaylistView do
  use SharePlayWeb, :view

  alias SharePlay.Playlists.{Playlist, Video}

  def link_to_add_video_fields do
    changeset =
      %Playlist{videos: [%Video{}]}
      |> Playlist.changeset()

    form = Phoenix.HTML.FormData.to_form(changeset, [])
    fields = render_to_string(__MODULE__, "video_fields.html", f: form)

    link("Add Video", to: "#", "data-template": fields, id: "add_videos")
  end
end
