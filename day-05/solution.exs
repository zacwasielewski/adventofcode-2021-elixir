defmodule Day5 do
  @input_file "day-05/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
        line
        |> String.split(" -> ")
        |> Enum.map(fn pair ->
          String.split(pair, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple
        end)
      end)
  end

  @doc """
  Is the line diagonal or orthogonal?
  """  
  def line_orientation(line) do
    [{x1, y1}, {x2, y2}] = line
    if abs(x2 - x1) == abs(y2 - y1), do: :diagonal, else: :orthogonal
  end
  
  @doc """
  Get {x,y} coordinates of every point covered by the line.
  """
  def line_points(line) do
    [{x1, y1}, {x2, y2}] = line
    
    case line_orientation(line) do
      :diagonal -> Enum.zip(x1..x2, y1..y2)
      :orthogonal -> for x <- x1..x2, y <- y1..y2, do: {x, y}
    end
  end
end

defmodule Day5.Part1 do
  import Day5
  
  @doc """
  Solve the puzzle using the following method:
  
  1. Parse the text input into an enum of line definitions
  2. Exclude diagonal lines (until part 2)
  3. Find all points that each line covers
  4. Combine all those points into a big list
  5. Count the duplicates
  """  
  def solve(input) do
    parse_input(input)
    |> Enum.filter(fn line -> line_orientation(line) == :orthogonal end)
    |> Enum.map(&line_points/1)
    |> List.flatten
    |> Enum.frequencies
    |> Map.values
    |> Enum.count(&(&1 > 1))
  end
end

defmodule Day5.Part2 do
  import Day5
  
  def solve(input) do
    parse_input(input)
    |> Enum.map(&line_points/1)
    |> List.flatten
    |> Enum.frequencies
    |> Map.values
    |> Enum.count(&(&1 > 1))
  end
end

input = Day5.get_input()
IO.puts "Part 1: #{Day5.Part1.solve(input)}"
IO.puts "Part 2: #{Day5.Part2.solve(input)}"
