defmodule ElixirExplorationWeb.SchemaTest do
  use ElixirExplorationWeb.ConnCase
  use Mimic

  @users_query """
  query GET_USERS (
    $orderInput: UserOrderInput!
  ) {
    users(order: $orderInput) {
      id
      email
    }
  }
  """
  test "query: users", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @users_query,
        "variables" => %{"orderInput" => %{"orderBy" => "email"}}
      })

    assert %{"data" => %{"users" => []}} = json_response(conn, 200)
  end

  @users_failed_query """
  query GET_USERS (
    $orderInput: UserOrderInput!
  ) {
    users(order: $orderInput) {
      id
      email
      unknownColumn
    }
  }
  """
  test "query: users with false params", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @users_failed_query,
        "variables" => %{"orderInput" => %{"orderBy" => "email"}}
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

  @upload_query """
  mutation FILE_UPLOAD($fileUpload: Upload!) {
    uploadFile(input: {file: $fileUpload})
  }
  """
  test "query: file upload success", %{conn: conn} do
    ExAws
    |> stub(:request, fn _ -> {:ok, :done} end)

    file_upload = %Plug.Upload{
      content_type: "text/plain",
      path: "test/random.txt",
      filename: "random.txt"
    }

    result =
      conn
      |> post("/api/graphql",
        query: @upload_query,
        variables: %{
          fileUpload: "file_upload"
        },
        file_upload: file_upload
      )
      |> json_response(200)

    assert result == %{
             "data" => %{"uploadFile" => "Success"}
           }
  end
end
