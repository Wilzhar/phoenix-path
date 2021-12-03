defmodule PhoenixPathWeb.PageController do
  use PhoenixPathWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
