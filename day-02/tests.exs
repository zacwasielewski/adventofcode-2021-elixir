ExUnit.start

defmodule Day2Test do
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

    assert 15  == input |> Day2.Part1.calculate_horizontal
    assert 10  == input |> Day2.Part1.calculate_depth
    assert 150 == input |> Day2.Part1.calculate_solution
  end
  
  test "part_2_example" do
    input = Day2.Part2.parse_input(@example_input)
    
    assert %{aim: 10, depth: 60, horizontal: 15} ==
      input
      |> Day2.Part2.calculate_position
  
    assert 900 ==
      input
      |> Day2.Part2.calculate_position
      |> Day2.Part2.calculate_solution
  end
end