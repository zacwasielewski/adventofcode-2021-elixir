ExUnit.start

defmodule Day5Test do
  use ExUnit.Case
  import Day5
  
  def example_input do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end

  test "orientation" do
    assert line_orientation([{8,0}, {0,8}]) == :diagonal
    assert line_orientation([{0,9}, {2,9}]) == :orthogonal
  end
  
  test "line_points" do
    assert line_points([{8,0}, {0,8}]) == [{8, 0}, {7, 1}, {6, 2}, {5, 3}, {4, 4}, {3, 5}, {2, 6}, {1, 7}, {0, 8}]
  end

  defmodule Part1 do
    use ExUnit.Case
    
    test "example" do
      input = Day5Test.example_input()
      assert 5 == Day5.Part1.solve(input)
    end
  end
    
  defmodule Part2 do
    use ExUnit.Case
    
    test "example" do
      input = Day5Test.example_input()
      assert 12 == Day5.Part2.solve(input)
    end
  end
end