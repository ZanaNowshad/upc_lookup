defmodule ProductTest do
  use ExUnit.Case
  alias Wmart.Product

  test "finds product info for a valid ups" do
    result = Product.get_product_info!("815301008439")
    expected = "[$99.99] Focusrite - Scarlett Solo (2nd Gen) - Audio Interface"
    assert result == expected
  end

  test "pads out the price" do
    result = Product.get_product_info!("078913280024")
    expected = "[$2.50] Keebler Graham Cracker Crumbs, 13.5 oz"

    assert result == expected
  end

  test "returns an apology if the api couldn't find the item" do
    result = Product.get_product_info!("190198459138")
    expected = "Sorry, we couldn't find that item"

    assert result == expected
  end
end
