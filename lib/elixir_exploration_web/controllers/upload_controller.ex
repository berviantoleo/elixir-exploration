defmodule ElixirExplorationWeb.UploadController do
  use ElixirExplorationWeb, :controller
  @extension_whitelist ~w(.jpg .jpeg .gif .png .pdf)

  def create(conn, %{"file" => %Plug.Upload{} = upload}) do
    if validate(upload) do
      path_type = Path.type(upload.filename)

      if path_type !== :relative do
        # error message
        send_filename_error(conn)
      else
        # double check
        cond do
          upload.filename =~ ".." ->
            send_filename_error(conn)

          upload.filename =~ "~" ->
            send_filename_error(conn)

          true ->
            File.mkdir("uploads")
            file_destination = get_filename(upload.filename)
            File.cp(upload.path, file_destination)
            json(conn, %{status: 200, message: "OK", path: file_destination})
        end
      end
    else
      send_filename_error(conn)
    end
  end

  defp validate(file) do
    file_extension =
      file.filename
      |> Path.extname()
      |> String.downcase()

    Enum.member?(@extension_whitelist, file_extension)
  end

  defp get_filename(filename) do
    [
      File.cwd!(),
      "/uploads/",
      "#{Ecto.UUID.generate()}-#{filename}"
    ]
    |> Path.join()
  end

  defp send_filename_error(conn) do
    conn
    |> put_status(400)
    |> json(%{message: "File not valid"})
  end
end
