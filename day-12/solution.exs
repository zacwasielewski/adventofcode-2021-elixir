defmodule Day12 do
  @input_file "day-12/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "-") end)
  end
  
  @doc """
  From a list of segment connections, build a map of possible
  from->to moves, ignoring any that go from "end" or to "start".
  """
  def build_moves(segments) do
    segments
    |> Enum.reduce(%{}, fn [p1, p2], acc ->        
      acc
      |> Map.update(p1, [p2], fn current -> [p2 | current] end)
      |> Map.update(p2, [p1], fn current -> [p1 | current] end)
      |> Map.drop(["end"])
      |> Map.map(fn {_, endpoints} -> List.delete(endpoints, "start") end)
    end)
  end
  
  def get_next_caves(moves, path) do
    moves
    |> Map.get(List.last(path), [])
    |> Enum.map(fn cave ->
      # Exclude any lowercase caves that we have already visited
      if cave == String.downcase(cave) && Enum.member?(path, cave) do
        :halt
      else
        cave
      end
    end)
  end
  
  def build_paths(moves) do    
    initial = { moves, _paths = [ ["start"] ] }
    infinity = Stream.iterate(0, &(&1+1))
    
    Enum.reduce_while(infinity, initial, fn _, acc ->
      { moves, paths } = acc

      # For all paths built so far, find all possible next moves.
      # Apply those moves to the current paths, branching if needed.
      new_paths =
      Enum.reduce(paths, [], fn path, acc ->
        # Based on the last move of this path, get all next possible moves:
        next_caves = get_next_caves(moves, path)
        
        if Enum.count(next_caves) > 0 do
          # Generate a new path for every possible next move:
          new_paths = Enum.map(next_caves, fn next -> path ++ [next] end)
          
          # Add the new paths to the accumulator
          acc ++ new_paths
        else
          # If there aren't any next moves, signal that this path is done
          if List.last(path) != :halt do
            acc ++ [ path ++ [:halt] ]
          else
            acc ++ [path]
          end
        end
      end)
      
      new_acc = { moves, new_paths }
      
      # Go until every list ends with :halt
      if Enum.all?(new_paths, fn x -> List.last(x) == :halt end) do
      
        # Do some cleanup of the mess we're returning
        cleaned_paths = new_paths
        |> Enum.map(fn x -> Enum.drop(x, -1) end)
        |> Enum.reject(fn x -> List.last(x) !== "end" end)
      
        { :halt, cleaned_paths }
      else
        { :cont, new_acc }
      end
    end)
  end
end

defmodule Day12.Part1 do
  import Day12
  
  def solve(input) do
    segments = parse_input(input)      
    moves = build_moves(segments)
    paths = build_paths(moves)
    
    Enum.count(paths)    
  end
end

input = Day12.get_input()
IO.puts "Part 1: #{Day12.Part1.solve(input)}"
#IO.puts "Part 2: #{Day12.Part2.solve(input)}"
