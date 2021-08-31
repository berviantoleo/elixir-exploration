defmodule ElixirExplorationWeb.Schema do
  use Absinthe.Schema

  alias ElixirExplorationWeb.Schema

  import_types(Schema.UserTypes)

  query do
    import_fields(:get_users)
  end
end
