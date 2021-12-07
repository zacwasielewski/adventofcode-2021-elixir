ExUnit.start

defmodule Day6Test do
  use ExUnit.Case
  
  def example_input do
    """
    3,4,3,1,2
    """
  end

  defmodule Part1 do
    use ExUnit.Case
    
    test "example" do      
      input = Day6Test.example_input()
      initial = Day6.Part1.parse_input(input)
      
      assert Day6.Part1.simulate(initial, 1) == [2,3,2,0,1]
      assert Day6.Part1.simulate(initial, 2) == [1,2,1,6,0,8]
      assert Day6.Part1.simulate(initial, 3) == [0,1,0,5,6,7,8]
      assert Day6.Part1.simulate(initial, 4) == [6,0,6,4,5,6,7,8,8]
      
      assert Enum.count(Day6.Part1.simulate(initial, 18)) == 26
      assert Enum.count(Day6.Part1.simulate(initial, 80)) == 5934      
    end
  end
    
  defmodule Part2 do
    use ExUnit.Case
    
    test "example" do
      input = Day6Test.example_input()
      lanternfish = Day6.Part2.parse_input(input)
      
      assert 7 == Day6.Part2.simulate(lanternfish, 3)  |> Map.values |> Enum.sum
      assert 26 == Day6.Part2.simulate(lanternfish, 18) |> Map.values |> Enum.sum
      assert 5934 == Day6.Part2.simulate(lanternfish, 80) |> Map.values |> Enum.sum
    end
  end
end