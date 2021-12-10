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
    import Day9
    import Day9.Part1
    
    test "example1" do
      input = Day9Test.example_input() |> Day9.parse_input
      
      assert find_local_minima(input) == [{{0, 1}, 1}, {{0, 9}, 0}, {{2, 2}, 5}, {{4, 6}, 5}]
      assert sum_local_minima(input) == 15
    end
  end

  defmodule Part2 do
    use ExUnit.Case
    import Day9
    import Day9.Part2
    
    test "matrix" do
      input = Day9Test.example_input() |> Day9.parse_input
      matrix = input

      assert in_matrix?(matrix, 1, 2) == true
      assert in_matrix?(matrix, -1, 0) == false
    end
        
    test "example1" do
      input = Day9Test.example_input() |> Day9.parse_input
      matrix = input
      
      basins = find_basins(matrix)
      
      top3 = basins
      |> Enum.map(fn basin ->
          Enum.count(basin)
        end)
      |> Enum.sort(:desc)
      |> Enum.take(3)
      assert top3 == [14, 9, 9]

      solution = top3
      |> Enum.reduce(fn x, acc -> x * acc end)
      assert solution == 14 * 9 * 9
    end
  end
end