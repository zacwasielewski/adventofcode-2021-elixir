ExUnit.start

defmodule Day2Test do
  use ExUnit.Case
  
  #@example_input [
  #  199,
  #  200,
  #  208,
  #  210,
  #  200,
  #  207,
  #  240,
  #  269,
  #  260,
  #  263,
  #]
  
  test "part_1_example" do
    input = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]
    
    assert [ 15, 10 ] ==
      input
      |> Day2.calculate_position

    assert 150 ==
      input
      |> Day2.calculate_position
      |> Day2.calculate_position_product
  end
end