defmodule Day8 do
  @input_file "day-08/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
end

defmodule Day8.Part1 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " | ") end)
  end
  
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
    parse_input(input) |> count_1_4_7_8
  end
end

defmodule Day8.Part2 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end

  def pattern_to_set(pattern) do
    pattern
    |> String.graphemes
    |> MapSet.new()
  end
  
  def decode_entry(line) do
    [input, output] = String.split(line, " | ", trim: true)

    decoded_input = decode_input_patterns(input)
    output_patterns = output
    |> String.split(" ", trim: true)
    |> Enum.map(&pattern_to_set/1)
    
    output_patterns
    |> Enum.map(fn o ->
      Enum.find_index(decoded_input, fn i -> i == o end)
    end)
    |> Enum.join
    |> String.to_integer
  end
  
  def decode_input_patterns(input) do
    values = input
    |> String.split(" ", trim: true)
    |> Enum.map(&pattern_to_set/1)
    
    # 1, 4, 7, 8 all have unique lengths
    n1 = Enum.find(values, fn x -> Enum.count(x) == 2 end)
    n4 = Enum.find(values, fn x -> Enum.count(x) == 4 end)
    n7 = Enum.find(values, fn x -> Enum.count(x) == 3 end)
    n8 = Enum.find(values, fn x -> Enum.count(x) == 7 end)
    
    # 3 has a length of 5 and includes all segments from 1
    n3 = values
    |> Enum.filter(fn x -> Enum.count(x) == 5 end)
    |> Enum.filter(fn x -> MapSet.subset?(n1, x) end)
    |> Enum.at(0)
    
    # 5 has a length of 5, is not 3, and includes 3 segments from 4
    n5 = values
    |> Enum.filter(fn x -> Enum.count(x) == 5 end)
    |> Enum.filter(fn x -> x !== n3 end)
    |> Enum.filter(fn x -> (MapSet.intersection(n4, x) |> Enum.count) == 3 end)
    |> Enum.at(0)

    # 2 has a length of 5, and is not 3 or 5
    n2 = values
    |> Enum.filter(fn x -> Enum.count(x) == 5 end)
    |> Enum.filter(fn x -> x !== n3 end)
    |> Enum.filter(fn x -> x !== n5 end)
    |> Enum.at(0)
    
    # 9 has a length of 6 and includes all segments from 4
    n9 = values
    |> Enum.filter(fn x -> Enum.count(x) == 6 end)
    |> Enum.filter(fn x -> MapSet.subset?(n4, x) end)
    |> Enum.at(0)
    
    # 0 has a length of 6, is not 9, and includes all segments from 1
    n0 = values
    |> Enum.filter(fn x -> Enum.count(x) == 6 end)
    |> Enum.filter(fn x -> x !== n9 end)
    |> Enum.filter(fn x -> MapSet.subset?(n1, x) end)
    |> Enum.at(0)

    # 6 has a length of 6, and is not 0 or 9
    n6 = values
    |> Enum.filter(fn x -> Enum.count(x) == 6 end)
    |> Enum.filter(fn x -> x !== n0 end)
    |> Enum.filter(fn x -> x !== n9 end)
    |> Enum.at(0)

    [ n0, n1, n2, n3, n4, n5, n6, n7, n8, n9 ]
  end
    
  def solve(input) do
    entries = parse_input(input)

    entries
    |> Enum.map(&decode_entry/1)
    |> Enum.sum
  end
end

input = Day8.get_input()
IO.puts "Part 1: #{Day8.Part1.solve(input)}"
IO.puts "Part 2: #{Day8.Part2.solve(input)}"
