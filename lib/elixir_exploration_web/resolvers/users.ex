defmodule ElixirExplorationWeb.Resolvers.Users do
  alias ElixirExploration.Accounts
  alias ElixirExploration.Accounts.User
  alias ElixirExploration.Repo

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end

  def user_by_id(%{id: id}, _context) do
    {:ok, Accounts.get_user!(id)}
  end

  def create_user(_, %{input: input}, _) do
    {:ok, Accounts.create_user(input)}
  end

  def list_users_orderly(%{order: %{order_by: order_by}}, _context) do
    import Ecto.Query, only: [from: 2]
    query = from u in User, order_by: [asc: ^order_by]
    {:ok, Repo.all(query)}
  end
end
