defmodule ElixirExplorationWeb.UploadController do
  use ElixirExplorationWeb, :controller

  def create(conn, %{"file" => %Plug.Upload{} = upload}) do
    IO.inspect(upload)
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
    |> put_status(404)
    |> json(%{message: "Wrong Filename"})
  end
end
