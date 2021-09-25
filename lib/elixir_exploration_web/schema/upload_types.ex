defmodule ElixirExplorationWeb.Schema.UploadTypes do
  use Absinthe.Schema.Notation

  alias ElixirExplorationWeb.Resolvers
  import_types(Absinthe.Plug.Types)

  object :upload_file do
    @desc """
      Upload a file
    """
    field :upload_file, :string do
      arg(:input, non_null(:file_input))
      resolve(&Resolvers.Uploads.upload_to_aws/3)
    end
  end

  input_object :file_input do
    field :file, non_null(:upload)
  end
end
