defmodule SharePlayWeb.PageController do
  use SharePlayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
