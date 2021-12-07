defmodule Day6 do
  @input_file "day-06/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
end

defmodule Day6.Part1 do
  def parse_input(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
  
  def simulate(lanternfish, days) do
    Enum.reduce(1..days, lanternfish, fn _, acc ->
      
      # Spawn new fish
      n = acc |> Enum.count(&(&1==0))
      new = List.duplicate(8, n)
      
      # Decrement or reset all the current fish
      old = Enum.map(acc, fn timer ->
        cond do
          timer > 0 -> timer - 1
          timer == 0 -> 6
        end          
      end)
      
      List.flatten([old, new])
    end)
  end
  
  def solve(input) do
    days = 80
    lanternfish = parse_input(input)
    |> simulate(days)
    |> Enum.count
  end
end

defmodule Day6.Part2 do  
  def parse_input(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies
  end
  
  def simulate(lanternfish, days) do
    1..days
    |> Enum.reduce(lanternfish, fn _, acc ->
      %{
        8 => Access.get(acc, 0, 0),
        7 => Access.get(acc, 8, 0),
        6 => Access.get(acc, 7, 0) + Access.get(acc, 0, 0),
        5 => Access.get(acc, 6, 0),
        4 => Access.get(acc, 5, 0),
        3 => Access.get(acc, 4, 0),
        2 => Access.get(acc, 3, 0),
        1 => Access.get(acc, 2, 0),
        0 => Access.get(acc, 1, 0),
      }
    end)
  end

  def solve(input) do
    days = 256
    lanternfish = Day6.Part2.parse_input(input)
    lanternfish
    |> Day6.Part2.simulate(days)
    |> Map.values
    |> Enum.sum
  end
end

input = Day6.get_input()
IO.puts "Part 1: #{Day6.Part1.solve(input)}"
IO.puts "Part 2: #{Day6.Part2.solve(input)}"
