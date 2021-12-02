defmodule Day2 do
  @input_file "day-02/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input |> String.split("\n", trim: true)
  end
end

defmodule Day2.Part1 do
  def sum_moves_by_direction(input, direction) do
    input
    |> Enum.filter(fn x -> String.starts_with?(x, direction) end)
    |> Enum.map(fn x -> String.replace(x, direction, "") end)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
  
  def solve(input) do
    forward = sum_moves_by_direction(input, "forward")
    up = sum_moves_by_direction(input, "up")
    down = sum_moves_by_direction(input, "down")
    depth = down - up
    
    forward * depth
  end
end

defmodule Day2.Part2 do
  def parse_input(input) do
    input
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
  end

  def next_position(position, move) do
    %{ aim: aim, depth: depth, horizontal: horizontal } = position
    [ direction, amount ] = move
    
    case direction do
      "down" -> %{position | aim: aim + amount}
      "up" -> %{position | aim: aim - amount}
      "forward" -> %{position | horizontal: horizontal + amount, depth: depth + aim * amount}
    end
  end

  def move_submarine(input) do
    initial = %{ horizontal: 0, depth: 0, aim: 0 }
    Enum.reduce(input, initial, fn move, acc -> next_position(acc, move) end)
  end
  
  def solve(input) do
    position = input
    |> parse_input
    |> move_submarine
    
    answer = position[:horizontal] * position[:depth]
  end
end

input = Day2.get_input()
IO.puts "Part 1: #{Day2.Part1.solve(input)}"
IO.puts "Part 2: #{Day2.Part2.solve(input)}"
