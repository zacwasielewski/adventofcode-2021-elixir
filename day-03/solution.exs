defmodule Day3 do
  @input_file "day-03/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input |> String.split("\n", trim: true)
  end
end

defmodule Day3.Part1 do
  def parse_input(input) do
    input
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
  end
  
  def solve(input) do
    forward = sum_moves_by_direction(input, "forward")
    up = sum_moves_by_direction(input, "up")
    down = sum_moves_by_direction(input, "down")
    depth = down - up
    
    forward * depth
  end
end

input = Day3.get_input()
IO.puts "Part 1: #{Day3.Part1.solve(input)}"
