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

    assert 3  == input |> Day2.Part1.sum_moves_by_direction("up")
    assert 13 == input |> Day2.Part1.sum_moves_by_direction("down")
    assert 15 == input |> Day2.Part1.sum_moves_by_direction("forward")

    assert 150 == input |> Day2.Part1.solve
  end
  
  test "part_2_example" do
    input = Day2.Part2.parse_input(@example_input)
    
    assert %{aim: 10, depth: 60, horizontal: 15} ==
      input
      |> Day2.Part2.move_submarine
  
    position = input |> Day2.Part2.move_submarine
    assert 900 == (position[:horizontal] * position[:depth])
  end
end