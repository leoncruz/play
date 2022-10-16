defmodule Play.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add(:name, :string, null: false)
      add(:url, :string, null: false)

      timestamps()
    end
  end
end
