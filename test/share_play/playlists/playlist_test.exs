defmodule SharePlay.PlaylistTest do
  use SharePlay.DataCase, async: true

  alias SharePlay.Playlists.Playlist

  describe "changeset/1" do
    test "name, category and video must be required" do
      changeset = Playlist.changeset(%Playlist{}, %{name: "", category: "", videos: []})

      assert %{name: ["can't be blank"]} = errors_on(changeset)
      assert %{category: ["can't be blank"]} = errors_on(changeset)
      assert %{videos: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
