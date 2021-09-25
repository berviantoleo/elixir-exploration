defmodule ElixirExplorationWeb.Resolvers.Uploads do
  alias ExAws.S3

  def upload_to_aws(_, %{input: input}, _) do
    IO.inspect(input.file)
    request = input.file.path
      |> S3.Upload.stream_file()
      # take care the filename, you should validate this
      |> S3.upload("upload-test-berv", "uploads/#{input.file.filename}")
      |> ExAws.request()
    case request do
      {:ok, _} -> {:ok, "Success"}
      {:error, _} -> {:error, "Please try again"}
    end
  end
end
