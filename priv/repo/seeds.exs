# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirExploration.Repo.insert!(%ElixirExploration.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "bervianto.leo@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "bervianto.leo.leo@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "bervianto@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "bervian@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "leo@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})

ElixirExploration.Repo.insert!(%ElixirExploration.Accounts.User{
  email: "berv@test.com",
  hashed_password: Argon2.hash_pwd_salt("randompwd123"),
})
