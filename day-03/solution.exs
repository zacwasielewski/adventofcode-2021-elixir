defmodule Day3 do
  @input_file "day-03/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input |> String.split("\n", trim: true)
  end
end

defmodule Day3.Part1 do
  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
  
  def flip_bit(bit) do
    case bit do
      0 -> 1
      1 -> 0
    end
  end
  
  def binary_string_to_decimal(s) do
    String.to_integer(s, 2)
  end

  def gamma(input) do    
    input
    # Convert the input to a (pseudo) matrix of integers
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(&String.to_integer/1) end)
    # Swap the rows and columns
    |> transpose
    # Get the most frequent bit in each "column"
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(fn x -> Enum.max_by(x, fn {_k, v} -> v end) |> elem(0) end)
    # Convert the result back to a string
    |> Enum.join
  end
  
  def epsilon(input) do
    gamma(input)
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&flip_bit/1)
    |> Enum.join
  end
  
  def power_consumption(gamma, epsilon) do
    gamma_decimal = binary_string_to_decimal(gamma)
    epsilon_decimal = binary_string_to_decimal(epsilon)
    gamma_decimal * epsilon_decimal
  end
  
  def solve(input) do
    gamma = gamma(input)
    epsilon = epsilon(input)
    power_consumption(gamma, epsilon)
  end
end

defmodule Day3.Part2 do
  def to_matrix(input) do
    input
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(&String.to_integer/1) end)    
  end
    
  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
  
  def most_frequent(list, tiebreaker) do
    f = Enum.frequencies(list)
    cond do
      f[0] >  f[1] -> 0
      f[0] <  f[1] -> 1
      f[0] == f[1] -> tiebreaker
    end
  end
  
  def least_frequent(list, tiebreaker) do
    f = Enum.frequencies(list)
    cond do
      f[0] >  f[1] -> 1
      f[0] <  f[1] -> 0
      f[0] == f[1] -> tiebreaker
    end
  end

  def binary_string_to_decimal(s) do
    String.to_integer(s, 2)
  end
  
  def filter_by_bit(input, position, bit) do
    Enum.filter(input, fn x -> String.at(x, position) == bit end)
  end

  def gamma(input) do    
    input
    |> to_matrix
    |> transpose
    |> Enum.map(fn x -> most_frequent(x, 1) end)
    |> Enum.join
  end
  
  def epsilon(input) do
    input
    |> to_matrix
    |> transpose
    |> Enum.map(fn x -> least_frequent(x, 0) end)
    |> Enum.join
  end
  
  def oxygen_generator_rating(input) do
    gamma(input)
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce_while(input, fn ({_, index}, acc) ->
      gamma = gamma(acc)
      bit = String.at(gamma, index)
      filtered = filter_by_bit(acc, index, bit)
      
      if Enum.count(filtered) == 1 do
        {:halt, Enum.at(filtered, 0)}
      else
        {:cont, filtered}
      end
    end)
  end

  def co2_scrubber_rating(input) do
    epsilon(input)
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce_while(input, fn ({_, index}, acc) ->
      epsilon = epsilon(acc)
      bit = String.at(epsilon, index)
      filtered = filter_by_bit(acc, index, bit)
      
      if Enum.count(filtered) == 1 do
        {:halt, Enum.at(filtered, 0)}
      else
        {:cont, filtered}
      end
    end)
  end

  def life_support_rating(o2_rating, co2_rating) do
    o2_decimal = binary_string_to_decimal(o2_rating)
    co2_decimal = binary_string_to_decimal(co2_rating)
    o2_decimal * co2_decimal    
  end
  
  def solve(input) do
    o2_rating = oxygen_generator_rating(input)
    co2_rating = co2_scrubber_rating(input)
    life_support_rating(o2_rating, co2_rating)    
  end
end

input = Day3.get_input()
IO.puts "Part 1: #{Day3.Part1.solve(input)}"
IO.puts "Part 2: #{Day3.Part2.solve(input)}"
