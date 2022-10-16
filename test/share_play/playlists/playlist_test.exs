defmodule Play.Playlists.PlaylistTest do
  use Play.DataCase, async: true

  alias Ecto.Changeset
  alias Play.Playlists.Playlist

  describe "changeset/1" do
    setup do
      video = %{name: "video #1", url: "http://example.com"}

      params = %{
        name: "playlist #1",
        category: "category #1",
        videos: [video]
      }

      %{params: params}
    end

    test "sucess: return valid changeset when given valid arguments", %{params: params} do
      changeset = Playlist.changeset(%Playlist{}, params)

      assert %Changeset{valid?: true, changes: _} = changeset
    end

    test "failure: return invalid changeset when name is not given", %{params: params} do
      params = Map.delete(params, :name)

      changeset = Playlist.changeset(%Playlist{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "failure: return invalid changeset when category is not given", %{params: params} do
      params = Map.delete(params, :category)

      changeset = Playlist.changeset(%Playlist{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{category: ["can't be blank"]} = errors_on(changeset)
    end

    test "failure: return invalid changeset when videos are not given", %{params: params} do
      params = Map.delete(params, :videos)

      changeset = Playlist.changeset(%Playlist{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{videos: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
