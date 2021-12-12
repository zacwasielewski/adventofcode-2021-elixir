defmodule Day11 do
  @input_file "day-11/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def to_matrix(input) do
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
  
  def in_matrix?(matrix, {row, col}) do
    {rows, cols} = matrix_size(matrix)
    
    cond do
      row < 0 -> false
      col < 0 -> false
      row >= rows -> false
      col >= cols -> false
      true -> true
    end
  end
  
  def neighbors({ row, col }) do
    [
      { row-1, col-1 },
      { row-1, col },
      { row-1, col+1 },
      { row, col-1 },
      { row, col },
      { row, col+1 },
      { row+1, col-1 },
      { row+1, col },
      { row+1, col+1 },
    ]
  end
  
  def energy(matrix, { row, col }) do
    matrix |> Enum.at(row) |> Enum.at(col)
  end
  
  def neighbors_energy(matrix, cell) do
    neighbors(cell)
    |> Enum.filter(fn {row, col} -> in_matrix?(matrix, {row, col}) end)
    |> Enum.map(fn {row, col} -> energy(matrix, {row, col}) end)
  end
  
  def set_flashed_to_zero(matrix) do
    matrix
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn energy ->
        if energy == nil, do: 0, else: energy
      end)
    end)    
  end
  
  def step(matrix) do
    
    # 1. First, the energy level of each octopus increases by 1.
    
    incremented = matrix
    |> Enum.map(fn row -> Enum.map(row, fn col -> col + 1 end) end)
    
    # 2. Then, any octopus with an energy level greater than 9 flashes.
    # This increases the energy level of all adjacent octopuses by 1,
    # including octopuses that are diagonally adjacent. If this causes an
    # octopus to have an energy level greater than 9, it also flashes.
    # This process continues as long as new octopuses keep having their
    # energy level increased beyond 9. (An octopus can only flash at most
    # once per step.)

    Stream.iterate(0, &(&1+1))
    |> Enum.reduce_while(incremented, fn _, acc ->
    
      new = acc
      |> Enum.with_index
      |> Enum.map(fn { cells, row } ->
        cells
        |> Enum.with_index
        |> Enum.map(fn { energy, col } ->
          
          case energy do
            :flashing -> :flashed
            :flashed -> nil
            nil -> nil
            _ ->
              neighbors = neighbors_energy(acc, {row, col})
              neighbors_flashing = neighbors |> Enum.count(fn x -> x == :flashing end)
              
              if energy + neighbors_flashing > 9 do
                :flashing
              else
                energy + neighbors_flashing
              end              
          end          
        end)
      end)
      
      changed? = new == acc
      if changed?, do: { :halt, new }, else: { :cont, new }
    end)

    # 3. Finally, any octopus that flashed during this step has its
    # energy level set to 0, as it used all of its energy to flash.
    
    |> set_flashed_to_zero
    
  end
end

defmodule Day11.Part1 do
#  import Day11
#  
#  def solve(input) do
#    input |> parse_input
#  end
end

#input = Day11.get_input()
#IO.puts "Part 1: #{Day11.Part1.solve(input)}"
#IO.puts "Part 2: #{Day11.Part2.solve(input)}"
