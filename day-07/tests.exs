ExUnit.start

defmodule Day7Test do
  use ExUnit.Case
  
  def example_input do
    """
    16,1,2,0,4,2,7,1,2,14
    """
  end

  defmodule Part1 do
    use ExUnit.Case
    
    test "example" do      
      input = Day7Test.example_input()
      crabs = Day7.parse_input(input)
      
      assert Day7.Part1.get_fuel_costs(crabs) |> Enum.min == 37
    end
  end
    
  defmodule Part2 do
    use ExUnit.Case
    
    test "example" do      
      input = Day7Test.example_input()
      crabs = Day7.parse_input(input)
      
      assert Day7.Part2.fuel_cost_options(crabs) |> Enum.min == 168
    end
  end
end