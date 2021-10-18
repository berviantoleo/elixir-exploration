defmodule ElixirExplorationWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  alias ElixirExplorationWeb.Resolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :email, :string
  end

  object :get_users do
    @desc """
    Get a list of users
    """
    field :users, list_of(:user) do
      resolve(&Resolvers.Users.list_users/2)
    end
  end

  object :get_user_by_id do
    @desc """
    Get a list of users
    """
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Users.user_by_id/2)
    end
  end

  object :get_users_orderly do
    @desc """
    Get a list of users by order
    """
    field :users, list_of(:user) do
      arg(:order, non_null(:user_order_input))
      resolve(&Resolvers.Users.list_users_orderly/2)
    end
  end

  object :create_user do
    @desc """
      Create a user
    """
    field :create_user, :user do
      arg(:input, non_null(:create_user_input))
      resolve(&Resolvers.Users.create_user/3)
    end
  end

  input_object :user_order_input do
    field :order_by, :user_order_field
  end

  @desc "The selected user order field"
  enum :user_order_field do
    value(:email, name: "email", description: "Email")
  end

  input_object :create_user_input do
    field :password, non_null(:string)
    field :email, non_null(:string)
  end
end
