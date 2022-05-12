defmodule DesafioBackendWeb.PageController do
  use DesafioBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
