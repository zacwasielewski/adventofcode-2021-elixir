ExUnit.start

defmodule Day1Test do
  use ExUnit.Case
  
  @example_input [
    199,
    200,
    208,
    210,
    200,
    207,
    240,
    269,
    260,
    263,
  ]
  
  test "count_depth_increases_example" do
    assert Day1.count_depth_increases(@example_input) === 7
  end
    
  test "sum_sliding_window_example" do
    assert Day1.sum_sliding_window(@example_input, 3) === [ 607, 618, 618, 617, 647, 716, 769, 792 ]
  end
    
  test "part_2_example" do
    windowed_input = Day1.sum_sliding_window(@example_input, 3)
    assert Day1.count_depth_increases(windowed_input) === 5
  end
end