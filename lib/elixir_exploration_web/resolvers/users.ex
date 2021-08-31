defmodule ElixirExplorationWeb.Resolvers.Users do
  alias ElixirExploration.Accounts

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end
end
