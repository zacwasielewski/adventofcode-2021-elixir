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

input = Day3.get_input()
IO.puts "Part 1: #{Day3.Part1.solve(input)}"
