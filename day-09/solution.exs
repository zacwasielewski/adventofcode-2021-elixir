defmodule Day9 do
  @input_file "day-09/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
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
  
  def in_matrix?(matrix, row, col) do
    {rows, cols} = matrix_size(matrix)
        
    cond do
      row < 0 -> false
      col < 0 -> false
      row >= rows -> false
      col >= cols -> false
      true -> true
    end
  end
  
  def height(matrix, row, col) do
    if in_matrix?(matrix, row, col) do
      matrix |> Enum.at(row) |> Enum.at(col)
    else
      nil
    end
  end
  
  def neighbor_coords({ row, col }) do
    [
      { row-1, col },
      { row, col+1 },
      { row+1, col },
      { row, col-1 },
    ]
  end
  
  def get_neighbors(matrix, { row, col }) do
    neighbor_coords({row, col})
    |> Enum.filter(fn {row, col} -> in_matrix?(matrix, row, col) end)
    |> Enum.map(fn {row, col} -> { {row, col}, height(matrix, row, col) } end)    
  end
  
  def local_minima?(matrix, row, col) do
    neighbors = get_neighbors(matrix, { row, col })
    neighbor_heights = Enum.map(neighbors, fn {_, height} -> height end)
    cell_height = height(matrix, row, col)
    
    Enum.all?(neighbor_heights, fn x -> x > cell_height end)
  end
  
  def find_local_minima(matrix) do
    {rows, cols} = matrix_size(matrix)
    
    for row <- 0..rows-1, col <- 0..cols-1 do
      if local_minima?(matrix, row, col),
        do: { {row, col}, height(matrix, row, col) },
        else: nil
    end
    |> Enum.reject(&is_nil/1)
  end  
end

defmodule Day9.Part1 do
  import Day9
  
  def risk_level(height) do
    height + 1
  end
  
  def sum_local_minima(matrix) do
    find_local_minima(matrix)
    |> Enum.map(fn { _, height } -> height end)
    |> Enum.map(&risk_level/1)
    |> Enum.sum
  end
  
  def solve(input) do
    input
    |> parse_input
    |> sum_local_minima
  end
end

defmodule Day9.Part2 do
  import Day9

  def find_basins(matrix) do
    
    find_local_minima(matrix)
    |> Enum.map(fn { {row, col}, height } ->
      
      initial = MapSet.new([{ {row, col}, height }])
      { rows, cols } = matrix_size(matrix)
      
      # Beginning with each local minimum, recursively find neighboring spaces
      # and add them to a basin if they're flat or uphill from the current point
      0..(rows * cols)
      |> Enum.reduce_while(initial, fn (_, acc) ->
          neighbors = acc
          |> Enum.map(fn { {row, col}, height } ->
            get_neighbors(matrix, { row, col })
            |> Enum.reject(fn { _, neighbor_height } -> neighbor_height < height end)
            |> Enum.reject(fn { _, neighbor_height } -> neighbor_height == 9 end)
          end)
          |> List.flatten
          |> MapSet.new
          
          new_acc = MapSet.union(acc, neighbors)
  
        # Quit when we run out of uphill
        if new_acc == acc, do: {:halt, new_acc}, else: {:cont, new_acc}
      end)
      
    end)
  end

  def solve(input) do
    input
    |> parse_input
    |> find_basins
    |> Enum.map(&Enum.count/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end
end

input = Day9.get_input()
IO.puts "Part 1: #{Day9.Part1.solve(input)}"
IO.puts "Part 2: #{Day9.Part2.solve(input)}"
