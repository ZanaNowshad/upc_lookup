defmodule ParserTest do
  use ExUnit.Case
  alias Wmart.Parser

  test "validates a string containing all numbers" do
    assert {:ok, _msg} = Parser.validate_line("815301008439")
  end

  test "invalidates a string with non-numbers" do
    upc = "1234abv123"
    expected = "Please send a valid UPC [#{upc}]"
    {:error, actual} = Parser.validate_line(upc)

    assert actual == expected
  end
end
