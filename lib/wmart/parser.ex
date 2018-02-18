defmodule Wmart.Parser do
  alias Wmart.Product

  def parse(data) do
    split = data
            |> String.split(~r/[\r\n]|\n/, trim: true)
            |> Enum.map_join("\r\n",fn(line) ->
              case line |> validate_line() do
                {:ok, data} ->
                  data |> Product.get_product_info!()
                {:error, msg} ->
                  msg
              end
            end)
  end

  def validate_line(line) do
    result = if Regex.match? ~r/^[0-9]+$/, line do
               {:ok, line}
             else
               {:error, "Please send a valid UPC [#{line}]"}
             end
    result
  end
end
