ExUnit.start

defmodule Day3Test do
  use ExUnit.Case
  
  @example_input """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """ |> String.split("\n", trim: true)
  
  test "part_1_example" do
    input = @example_input

    

    #assert 150 == input |> Day2.Part1.solve
  end
end