defmodule Day2 do
  @input_file "day-02/input.txt"
  
  defp get_input do
    {:ok, input} = File.read(@input_file)
    
    input
    |> String.split("\n", trim: true)
  end
  
  def next_position(current, move) do
    [ horizontal, depth ] = current
    [ direction, amount_string ] = String.split(move, " ")
    amount = String.to_integer(amount_string)
    
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
  
  def calculate_position_product(position) do
    Enum.at(position, 0) * Enum.at(position, 1)
  end
    
  def part1 do
    get_input()
    |> calculate_position
    |> calculate_position_product
  end
end

IO.puts "Part 1: #{Day2.part1}"
#IO.puts "Part 2: #{Day2.part2}"
