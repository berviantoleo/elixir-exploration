defmodule ElixirExploration.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role, :string, null: false, default: "user"

      timestamps()
    end
  end
end
