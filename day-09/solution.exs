defmodule Day9 do
  @input_file "day-09/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
end

defmodule Day9.Part1 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes
      |> Enum.map(&String.to_integer/1)
    end)
  end
  
  def matrix_size(matrix) do
    rows = Enum.count(matrix)
    cols = Enum.count(Enum.at(matrix, 0))
    { rows, cols }
  end
  
  def height(matrix, row, col) do
    {rows, cols} = matrix_size(matrix)
    
    cond do
      row < 0 -> nil
      col < 0 -> nil
      row >= rows -> nil
      col >= cols -> nil
      true->
        matrix
        |> Enum.at(row)
        |> Enum.at(col)
    end
  end
  
  def risk_level(height) do
    height + 1
  end
  
  def local_minima?(matrix, row, col) do    
    neighbors = [
      { row-1, col },
      { row, col+1 },
      { row+1, col },
      { row, col-1 },
    ]
    
    neighbor_heights = Enum.map(neighbors, fn {row, col} -> height(matrix, row, col) end)
    cell_height = height(matrix, row, col)
    
    Enum.all?(neighbor_heights, fn x -> x > cell_height end)
  end
  
  def find_local_minima(matrix) do
    {rows, cols} = matrix_size(matrix)
    
    for row <- 0..rows-1, col <- 0..cols-1 do
      if local_minima?(matrix, row, col), do: height(matrix, row, col), else: nil
    end
    |> Enum.reject(&is_nil/1)
  end
  
  def sum_local_minima(matrix) do
    find_local_minima(matrix)
    |> Enum.map(&risk_level/1)
    |> Enum.sum
  end
  
  def solve(input) do
    input
    |> parse_input
    |> sum_local_minima
  end
end

input = Day9.get_input()
IO.puts "Part 1: #{Day9.Part1.solve(input)}"
#IO.puts "Part 2: #{Day9.Part2.solve(input)}"
