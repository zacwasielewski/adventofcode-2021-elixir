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
      gamma_decimal   = binary_string_to_decimal(gamma)
      epsilon_decimal = binary_string_to_decimal(epsilon)

      assert gamma == "10110"
      assert epsilon == "01001"
      assert gamma_decimal == 22
      assert epsilon_decimal == 9
      
      assert power_consumption(gamma, epsilon) === 198
      
      assert 198 == input |> Day3.Part1.solve
    end
  end

  defmodule Part2 do
    use ExUnit.Case
    import Day3.Part2
    
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
    
    test "part_2_example" do
      input = @example_input

      o2_rating  = oxygen_generator_rating(input)
      co2_rating = co2_scrubber_rating(input)
      o2_rating_decimal = binary_string_to_decimal(o2_rating)
      co2_rating_decimal = binary_string_to_decimal(co2_rating)
            
      assert o2_rating === "10111"
      assert co2_rating === "01010"
      assert o2_rating_decimal == 23
      assert co2_rating_decimal == 10
      
      assert life_support_rating(o2_rating, co2_rating) === 230
    end
  end
end