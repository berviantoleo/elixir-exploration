defmodule ElixirExplorationWeb.NumberController do
  use ElixirExplorationWeb, :controller

  def generate(conn, _params) do
    json(conn, %{count: :rand.uniform(10000)})
  end

  def grouped(conn, _params) do
    data_array = [
      %{city_id: 1, city: "Bandung", name: "Babu"},
      %{city_id: 1, city: "Bandung", name: "Kijang"},
      %{city_id: 2, city: "Jakarta", name: "Kandang"}
    ]

    grouped =
      data_array
      |> Enum.group_by(fn data -> %{city_id: data.city_id, city: data.city} end)
      |> Enum.map(fn {grouped, data} ->
        IO.inspect(grouped)
        Map.merge(grouped, %{warehouses: data})
      end)

    conn
    |> json(grouped)
  end
end
