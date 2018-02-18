defmodule Wmart.Product do
  require Logger

  def get_product_info!(upc) do
    Logger.info "Looking up UPC: #{upc}"

    str = "http://api.walmartlabs.com/v1/items?apiKey=mvshhv6w2wxb2n83tnkkw8xa&upc=#{upc}"
    url = to_charlist str

    {:ok, {{_prot, status, _msg}, _h, body}} = :httpc.request(:get, {url, []}, [], [])
    case status do
      200 ->
        parse_body(body)
      404 ->
        "Sorry, we couldn't find that item"
      503 ->
        "Sorry, there was a problem with the lookup service, please try again"
    end
  end

  defp parse_body(body) do
    json = body |> List.to_string

    price = json |> parse_price
    name = json |> parse_name
    "[$#{price}] #{name}"
  end

  defp parse_name(json) do
    [_match, name] = Regex.run(~r/\"name\":\"(.+?)\",/, json)
    name
  end

  defp parse_price(json) do
    [_match, price] = Regex.run(~r/\"salePrice\":(.+?),/, json)

    if Regex.match? ~r/^[0-9]+\.[0-9]$/, price do
      "#{price}0"
    else
      price
    end
  end
end
