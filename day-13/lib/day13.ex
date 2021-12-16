defmodule Day13 do
  @input_file "lib/day13_input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    [ dots, folds ] = input
    |> String.split("\n\n")
    |> Enum.map(fn line -> String.split(line, "\n", trim: true) end)
    
    {
      dots
      |> Enum.map(fn line ->
        line
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple() end),
      
      folds
      |> Enum.map(fn line -> Regex.run(~r/fold along (x|y)=(\d+)/, line) end)
      |> Enum.map(fn [_, axis, position] -> {String.to_atom(axis), String.to_integer(position)} end)
    }
  end
  
  def create_paper({rows, cols}) do
    Nx.broadcast(0, {rows, cols}, names: [:y, :x])
  end
  
  def mark_dots(instructions) do
    cols = (instructions |> Enum.map(fn {x, _} -> x end) |> Enum.max) + 1
    rows = (instructions |> Enum.map(fn {_, y} -> y end) |> Enum.max) + 1
    
    paper = create_paper({ rows, cols })
    
    instructions
    |> Enum.reduce(paper, fn { y, x }, paper ->
      Nx.put_slice(paper, [x, y], Nx.tensor([[1]]))
    end)
  end
  
  def overlay_papers(paper1, paper2) do
    max_x = Enum.max([
      Nx.axis_size(paper1, :x),
      Nx.axis_size(paper2, :x)
    ])
    
    max_y = Enum.max([
      Nx.axis_size(paper1, :y),
      Nx.axis_size(paper2, :y)
    ])
    
    paper1_padded = Nx.pad(paper1, 0, [{0, max_y - Nx.axis_size(paper1, :y), 0}, {0, max_x - Nx.axis_size(paper1, :x), 0}])
    paper2_padded = Nx.pad(paper2, 0, [{0, max_y - Nx.axis_size(paper2, :y), 0}, {0, max_x - Nx.axis_size(paper2, :x), 0}])

    Nx.bitwise_or(paper1_padded, paper2_padded)
  end

  def fold_paper(paper, :x, line) do
    fold_paper(paper, :left, line)
  end

  def fold_paper(paper, :y, line) do
    fold_paper(paper, :up, line)
  end
  
  def fold_paper(paper, :left, line) do
    length = Nx.axis_size(paper, :x)
    
    left = Nx.slice_axis(paper, 0, line, :x) |> Nx.reverse(axes: [:x])
    right = Nx.slice_axis(paper, line + 1, length - (line + 1), :x)

    overlay_papers(left, right) |> Nx.reverse(axes: [:x])
  end
  
  def fold_paper(paper, :up, line) do
    length = Nx.axis_size(paper, :y)
    
    top = Nx.slice_axis(paper, 0, line, :y) |> Nx.reverse(axes: [:y])
    bottom = Nx.slice_axis(paper, line + 1, length - (line + 1), :y)

    overlay_papers(top, bottom) |> Nx.reverse(axes: [:y])
  end
  
  def solve_part_1 do
    instructions = get_input() |> parse_input
    { dots, folds } = instructions
    
    paper = mark_dots(dots)
    
    { fold_axis, fold_line } = List.first(folds)
    folded = fold_paper(paper, fold_axis, fold_line)
    
    Nx.sum(folded) |> Nx.to_number
  end
  
  def solve_part_2 do
    instructions = get_input() |> parse_input
    { dots, folds } = instructions
    
    paper = mark_dots(dots)
    
    Enum.reduce(folds, paper, fn fold, paper ->

      { fold_axis, fold_line } = fold
      fold_paper(paper, fold_axis, fold_line)
      
    end)
    |> Nx.to_heatmap
  end
end

IO.puts "Part 1: #{Day13.solve_part_1}"
IO.puts "Part 2:"
IO.inspect Day13.solve_part_2
