defmodule ElixirExplorationWeb.PageController do
  use ElixirExplorationWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
