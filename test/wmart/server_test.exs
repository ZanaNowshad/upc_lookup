defmodule ServerTest do
  use ExUnit.Case
  alias Wmart.Server

  test "validates a string containing all numbers" do
    assert {:ok, _msg} = Server.validate_line("815301008439")
  end
end
