ExUnit.start

defmodule Day3Test do
  defmodule Part1 do
    use ExUnit.Case
    import Day3.Part1
    
    @example_input """
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
      """ |> String.split("\n", trim: true)
    
    test "part_1_example" do
      input = @example_input
  
      gamma   = gamma(input)
      epsilon = epsilon(input)
      
      assert gamma == "10110"
      assert epsilon == "01001"
      
      gamma_decimal   = binary_string_to_decimal(gamma)
      epsilon_decimal = binary_string_to_decimal(epsilon)

      assert gamma_decimal == 22
      assert epsilon_decimal == 9

      assert power_consumption(gamma, epsilon) === 198
      
      assert 198 == input |> Day3.Part1.solve
    end
  end
end