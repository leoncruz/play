defmodule SharePlay.VideoTest do
  use SharePlay.DataCase, async: true

  alias SharePlay.Playlists.Video

  describe "changeset" do
    test "name, url and playlist_id must be required" do
      changeset = Video.changeset(%Video{}, %{name: "", url: "", playlist_id: ""})

      assert %{url: ["can't be blank"]} = errors_on(changeset)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
      assert %{playlist_id: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "playlist_video_changeset" do
    test "name ad url must be required" do
      changeset = Video.playlist_video_changeset(%Video{}, %{name: "", url: "", playlist_id: ""})

      assert %{url: ["can't be blank"]} = errors_on(changeset)
      assert %{name: ["can't be blank"]} = errors_on(changeset)

      refute match?(%{playlist_id: ["can't be blank"]}, errors_on(changeset))
    end
  end
end
