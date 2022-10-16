defmodule Play.PlaylistsTest do
  use Play.DataCase, async: true

  alias Play.Playlists.{Playlist, Video}
  alias Play.Playlists

  describe "list_videos/0" do
    setup do
      video1 = %Video{
        name: "video 1",
        url: "http://www.example.com",
        updated_at: ~N[2022-10-15 22:35:00]
      }

      video2 = %Video{name: "video 2", url: "http://www.example.com"}

      {:ok, _} =
        %Playlist{
          name: "Example",
          category: "Example",
          videos: [video1, video2]
        }
        |> Playlist.changeset()
        |> Repo.insert()

      [video1, video2] = Repo.all(Video)

      %{video1: video1, video2: video2}
    end

    test "sucess: return videos in descending order by updated_at", context do
      %{video1: video1, video2: video2} = context

      result = Playlists.list_videos()

      assert result == [video2, video1]
    end
  end

  describe "video_changeset/1" do
    test "failure: return a invalid changeset" do
      assert %Ecto.Changeset{valid?: false} = Playlists.video_changeset(%Video{})
    end
  end

  describe "video_changeset/2" do
    test "failure: return a invalid changeset when given invalid arguments" do
      assert %Ecto.Changeset{valid?: false} = Playlists.video_changeset(%Video{})
    end

    test "sucess: return a valid changeset when given valid arguments" do
      video = %Video{name: "video #1", url: "http://example.com", playlist_id: 1}

      assert %Ecto.Changeset{valid?: true} = Playlists.video_changeset(video)
    end
  end
end
