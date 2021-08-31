defmodule ElixirExplorationWeb.PageController do
  use ElixirExplorationWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def not_found(conn, _) do
    conn
    |> put_status(404)
    |> json(%{message: "Not Found"})
  end
end
