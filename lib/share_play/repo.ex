defmodule SharePlay.Repo do
  use Ecto.Repo,
    otp_app: :share_play,
    adapter: Ecto.Adapters.Postgres
end
