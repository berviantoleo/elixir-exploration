defmodule ElixirExplorationWeb.Schema do
  use Absinthe.Schema

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [
      ElixirExplorationWeb.Middlewares.HandleChangesetErrors
    ]
  end
  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation] do
    Enum.map(middleware, &ElixirExplorationWeb.Middlewares.ExceptionMiddleware.wrap/1)
  end
  # if it's any other object keep things as is
  def middleware(middleware, _field, _object), do: middleware

  alias ElixirExplorationWeb.Schema

  import_types(Schema.UserTypes)

  query do
    # import_fields(:get_users)
    import_fields(:get_users_orderly)
    import_fields(:get_user_by_id)
  end

  mutation do
    import_fields(:create_user)
  end
end
