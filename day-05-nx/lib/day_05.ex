defmodule Day05 do
  @input_file "lib/day_05_input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def get_field_dimensions(lines) do
    x = lines |> Enum.map(fn [[x1, _y1], [x2, _y2]] -> Enum.max([x1, x2]) end) |> Enum.max()
    y = lines |> Enum.map(fn [[_x1, y1], [_x2, y2]] -> Enum.max([y1, y2]) end) |> Enum.max()
    {x + 1, y + 1}
  end
  
  def is_orthogonal? line do
    [p1, p2] = line
    delta_x = Enum.at(p2, 0) - Enum.at(p1, 0)
    delta_y = Enum.at(p2, 1) - Enum.at(p1, 1)
    delta_x == 0 || delta_y == 0
  end
  
  def lines_to_tensors(lines, base_tensor) do
    lines
    |> Enum.filter(&is_orthogonal?/1)
    |> Enum.map(fn line ->
        [[x1, y1], [x2, y2]] = line
        
        length_x = Enum.max([x1, x2]) - Enum.min([x1, x2])
        length_y = Enum.max([y1, y2]) - Enum.min([y1, y2])
        
        direction = if length_x > 0, do: :horizontal, else: :vertical
        
        slice = case direction do
          :horizontal -> Nx.tensor([List.duplicate(1, length_x + 1)])
          :vertical   -> Nx.tensor([List.duplicate(1, length_y + 1)]) |> Nx.transpose
        end
        
        start = case direction do
          :horizontal -> [Nx.tensor(y1), Nx.tensor(Enum.min([x1, x2]))]
          :vertical   -> [Nx.tensor(Enum.min([y1, y2])), Nx.tensor(x1)]
        end
        
        Nx.put_slice(base_tensor, start, slice)
      end)
  end
    
  def solve(input) do
    lines = parse_input(input)
    dimensions = get_field_dimensions(lines)    
    base_tensor = Nx.broadcast(0, dimensions)
    
    tensors = lines_to_tensors(lines, base_tensor)
    
    tensors
    |> Enum.reduce(fn tensor, acc -> Nx.add(acc, tensor) end)
    |> Nx.to_flat_list()
    |> Enum.filter(fn x -> x > 1 end)
    |> Enum.count()
    |> IO.inspect(label: "solution", limit: :infinity)
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
        line
        |> String.split(" -> ")
        |> Enum.map(fn pair ->
          String.split(pair, ",") |> Enum.map(&String.to_integer/1)
        end)
      end)
  end
end

input = Day05.get_input()
IO.puts "Part 1: #{Day05.solve(input)}"
#IO.puts "Part 2: #{Day4.Part2.solve(input)}"
