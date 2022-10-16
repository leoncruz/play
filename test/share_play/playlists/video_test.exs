defmodule SharePlay.Playlists.VideoTest do
  use SharePlay.DataCase, async: true

  alias SharePlay.Playlists.Video
  alias Ecto.Changeset

  describe "changeset/1" do
    setup do
      %{params: %{name: "video #1", url: "http://example.com", playlist_id: 1}}
    end

    test "sucess: return valid changeset when given valid arguments", %{params: params} do
      changeset = Video.changeset(%Video{}, params)

      assert %Changeset{valid?: true, changes: _} = changeset
    end

    test "failure: return invalid changeset when name is not given", %{params: params} do
      params = Map.delete(params, :name)

      changeset = Video.changeset(%Video{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "failure: return invalid changeset when url is not given", %{params: params} do
      params = Map.delete(params, :url)

      changeset = Video.changeset(%Video{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{url: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "playlist_video_changeset/1" do
    setup do
      %{params: %{name: "video #1", url: "http://example.com"}}
    end

    test "sucess: return valid changeset when given valid arguments", %{params: params} do
      changeset = Video.playlist_video_changeset(%Video{}, params)

      assert %Changeset{valid?: true, changes: _} = changeset
    end

    test "failure: return invalid changeset when name is not given", %{params: params} do
      params = Map.delete(params, :name)

      changeset = Video.changeset(%Video{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "failure: return invalid changeset when url is not given", %{params: params} do
      params = Map.delete(params, :url)

      changeset = Video.changeset(%Video{}, params)

      assert %Changeset{valid?: false, changes: _} = changeset
      assert %{url: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
