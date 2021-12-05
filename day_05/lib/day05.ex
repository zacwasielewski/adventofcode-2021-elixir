defmodule Day05 do
  def parse_input(input) do
    line_defs = input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
        line
        |> String.split(" -> ")
        |> Enum.map(fn pair ->
          String.split(pair, ",") |> Enum.map(&String.to_integer/1)
        end)
      end)
  end
  
  def is_orthogonal? line do
    [p1, p2] = line
    delta_x = Enum.at(p2, 0) - Enum.at(p1, 0)
    delta_y = Enum.at(p2, 1) - Enum.at(p1, 1)
    delta_x == 0 || delta_y == 0
  end
  
  def create_tensor(array) do
    Nx.tensor(array)
  end
end
