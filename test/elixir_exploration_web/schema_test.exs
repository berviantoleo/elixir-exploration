defmodule ElixirExplorationWeb.SchemaTest do
  use ElixirExplorationWeb.ConnCase

  @users_query """
  query {
    users {
      id
      name
      email
      role
    }
  }
  """
  test "query: users", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @users_query
      })

    assert json_response(conn, 200) == %{"data" => %{"users" => []}}
  end

  @users_query """
  query {
    users {
      id
      name
      email
      role
      unknownColumn
    }
  }
  """
  test "query: users with false params", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @users_query
      })

    assert json_response(conn, 200) == %{
             "errors" => [
               %{
                 "locations" => [%{"column" => 5, "line" => 7}],
                 "message" => "Cannot query field \"unknownColumn\" on type \"User\"."
               }
             ]
           }
  end
end
