defmodule Day8 do
  @input_file "day-08/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " | ") end)
  end
end

defmodule Day8.Part1 do
  def count_1_4_7_8(lines) do
    lines
    |> Enum.map(fn [_input, output] ->
        output
        |> String.split(" ")
        |> Enum.count(fn value -> String.length(value) in [2, 3, 4, 7] end)
      end)
    |> Enum.sum
  end
    
  def solve(input) do
    Day8.parse_input(input) |> count_1_4_7_8
  end
end

input = Day8.get_input()
IO.puts "Part 1: #{Day8.Part1.solve(input)}"
