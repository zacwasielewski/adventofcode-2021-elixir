defmodule Day2 do
  @input_file "day-02/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)    
    parse_input(input)
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
  end
end

defmodule Day2.Part1 do
  import Day2
  
  def next_position(current, move) do
    [ horizontal, depth ] = current
    [ direction, amount ] = move
    
    case direction do
      "forward" -> [ horizontal + amount, depth ]
      "down" -> [ horizontal, depth + amount]
      "up" -> [ horizontal, depth - amount]
    end
  end
    
  def calculate_position(input) do
    initial = [0, 0]
    Enum.reduce(input, initial, fn move, acc -> next_position(acc, move) end)
  end
    
  def calculate_solution(position) do
    Enum.at(position, 0) * Enum.at(position, 1)
  end

  def solve do
    get_input()
    |> calculate_position
    |> calculate_solution
  end  
end

defmodule Day2.Part2 do
  import Day2

  def next_position(position, move) do
    %{ aim: aim, depth: depth, horizontal: horizontal } = position
    [ direction, amount ] = move
    
    case direction do
      "down" -> %{position | aim: aim + amount}
      "up" -> %{position | aim: aim - amount}
      "forward" -> %{position | horizontal: horizontal + amount, depth: depth + aim * amount}
    end
  end

  def calculate_position(input) do
    initial = %{ horizontal: 0, depth: 0, aim: 0 }
    Enum.reduce(input, initial, fn move, acc -> next_position(acc, move) end)
  end

  def calculate_solution(position) do    
    position[:horizontal] * position[:depth]
  end
  
  def solve do
    get_input()
    |> calculate_position
    |> calculate_solution
  end
end

IO.puts "Part 1: #{Day2.Part1.solve}"
IO.puts "Part 2: #{Day2.Part2.solve}"
