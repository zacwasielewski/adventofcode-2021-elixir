defmodule Day7 do
  @input_file "day-07/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule Day7.Part1 do
  def get_fuel_costs(crabs) do
    min = Enum.min(crabs)
    max = Enum.max(crabs)
    range = min..max
    range
    |> Enum.map(fn position ->
        crabs
        |> Enum.map(fn crab -> abs(crab - position) end)
        |> Enum.sum
      end)
  end
  
  def solve(input) do
    crabs = Day7.parse_input(input)
    get_fuel_costs(crabs) |> Enum.min
  end
end

defmodule Day7.Part2 do
  @doc """
  Fuel costs increase as triangular numbers:
  https://en.wikipedia.org/wiki/Triangular_number
  """
  def fuel_cost(steps) do
    (steps * (steps + 1) / 2) |> round
  end
    
  @doc """
  Calculate the fuel costs to move all crabs
  to each possible position of their range.
  """
  def fuel_cost_options(crabs) do
    Enum.min(crabs)..Enum.max(crabs)
    |> Enum.map(fn position ->
        crabs
        |> Enum.map(fn crab -> abs(crab - position) |> fuel_cost end)
        |> Enum.sum
      end)
  end

  @doc """
  Get all possible fuel cost options, then select the cheapest.
  """
  def solve(input) do
    crabs = Day7.parse_input(input)
    fuel_cost_options(crabs) |> Enum.min
  end
end

input = Day7.get_input()
IO.puts "Part 1: #{Day7.Part1.solve(input)}"
IO.puts "Part 2: #{Day7.Part2.solve(input)}"
