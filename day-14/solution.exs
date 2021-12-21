defmodule Day14 do
  @input_file "day-14/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
end

defmodule Day14.Part1 do
  #import Day14
  
  def parse_input(input) do
    [ template, rules ] = input
    |> String.split("\n\n")
    |> Enum.map(fn line -> String.split(line, "\n", trim: true) end)
    
    %{
      polymer: List.first(template),
      rules: rules
        |> Enum.map(fn line -> String.split(line, " -> ") end)
        |> Enum.map(fn [k, v] -> {k, v} end)
        |> Enum.map(fn {k, v} -> {k, String.at(k, 0) <> v <> String.at(k, 1) } end)
        |> Enum.into(%{})
    }
  end
  
  def extract_pairs(polymer) do
    polymer
    |> String.graphemes
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.join/1)    
  end
  
  def most_least_common_elements(polymer) do
    freqs = polymer
    |> String.graphemes
    |> Enum.frequencies
    |> Enum.sort_by(fn {_, v} -> v end)
    
    { List.last(freqs), List.first(freqs) }
  end
  
  def apply_rules(polymer, rules) do
    # Split the polymer into overlapping chunks of 2 characters
    pairs = extract_pairs(polymer)
    
    # Apply the rules to each chunk, then separate the first chunk from the rest
    [head | tail] = pairs
    |> Enum.map(fn x -> Map.fetch!(rules, x) end)
    
    # Join the first chunk (3 characters) with the last 2
    # characters of all the other chunks
    head <> (
      tail
      |> Enum.map(fn x -> String.slice(x, -2, 2) end)
      |> Enum.join
    )
  end

  def apply_rules(polymer, rules, times) do
    Enum.reduce(1..times, polymer, fn _, acc ->
      apply_rules(acc, rules)
    end)
  end
  
  def solve(input) do
    %{ polymer: polymer, rules: rules } = parse_input(input)
    new_polymer = apply_rules(polymer, rules, 10)

    { {_, most_common}, {_, least_common}} = most_least_common_elements(new_polymer)
    
    most_common - least_common
  end
end

defmodule Day14.Part2 do
  #import Day14

  def parse_input(input) do
    [ template, rules ] = input
    |> String.split("\n\n")
    |> Enum.map(fn line -> String.split(line, "\n", trim: true) end)
    
    %{
      polymer: List.first(template),
      rules: rules
        |> Enum.map(fn line -> String.split(line, " -> ") end)
        |> Enum.map(fn [k, v] -> {k, [String.at(k, 0) <> v, v <> String.at(k, 1)] } end)
        |> Enum.into(%{})
    }
  end
  
  def extract_pairs(polymer) do
    polymer
    |> String.graphemes
    |> Enum.chunk_every(2, 1, [0])
    |> Enum.map(&Enum.join/1)    
  end
  
  def count_pairs(polymer) do    
    polymer
    |> extract_pairs
    |> Enum.frequencies
  end
  
  def count_elements(pairs) do
    pairs
    |> Enum.map(fn {pair, count} -> { String.at(pair, 0), count } end)
    |> Enum.group_by(fn {k, _} -> k end)
    |> Map.map(fn {_, counts} ->
        counts
        |> Enum.map(fn {_, count} -> count end)
        |> Enum.sum end
      )
  end
  
  def sum_by_key(list_of_pair_counts) do
    list_of_pair_counts
    |> Enum.group_by(fn {k, _} -> k end)
    |> Enum.map(fn {k, v} ->
      {k, Enum.map(v, fn {_, v2} -> v2 end) |> Enum.sum}
    end)
    |> Enum.filter(fn { _, n } -> n > 0 end)
    |> Enum.into(%{})
  end
  
  def min_max(pairs) do
    {{_, min}, {_, max}} = pairs
    |> Enum.min_max_by(fn {_, count} -> count end)
    
    {min, max}
  end
  
  def recalculate_pairs(pairs, rules) do    
    pairs
    |> Enum.flat_map(fn {pair, count} -> [
        rules
        |> Map.get(pair, [pair])
        |> Enum.map(fn x -> {x, count} end)
      ] end)
    |> List.flatten
    |> sum_by_key
  end
  
  def process_polymer(polymer, rules, times) do
    count = polymer |> count_pairs
    Enum.reduce(1..times, count, fn _, acc ->
      recalculate_pairs(acc, rules)
    end)
  end

  def solve(input) do
    %{ polymer: polymer, rules: rules } = parse_input(input)

    { min, max } =
    process_polymer(polymer, rules, 40)
    |> count_elements
    |> min_max
    
    max - min
  end
end

input = Day14.get_input()
IO.puts "Part 1: #{Day14.Part1.solve(input)}"
IO.puts "Part 2: #{Day14.Part2.solve(input)}"
