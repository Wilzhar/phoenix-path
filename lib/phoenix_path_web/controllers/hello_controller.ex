defmodule PhoenixPathWeb.HelloController do
  use PhoenixPathWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    conn
    |> assign(:messenger, messenger)
    |> render("show.html")
  end
end
