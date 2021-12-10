ExUnit.start

defmodule Day9Test do
  use ExUnit.Case
  
  def example_input do
    """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """
  end

  defmodule Part1 do
    use ExUnit.Case
    import Day9.Part1
    
    test "example1" do
      input = Day9Test.example_input() |> Day9.Part1.parse_input
      
      assert find_local_minima(input) == [1, 0, 5, 5]
      assert sum_local_minima(input) == 15
    end
  end
end