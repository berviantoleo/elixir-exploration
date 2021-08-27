defmodule ElixirExploration.Repo do
  use Ecto.Repo,
    otp_app: :elixir_exploration,
    adapter: Ecto.Adapters.Postgres
end
