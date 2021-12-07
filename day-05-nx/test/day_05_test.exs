defmodule Day05Test do
  use ExUnit.Case

  import Day05
  
  test "part1_example" do    
    input = """
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
      """
    
    lines = parse_input(input)
    dimensions = get_field_dimensions(lines)

    base_tensor = Nx.broadcast(0, dimensions)
    
    tensors = lines_to_tensors(lines, base_tensor)
    
    solution = tensors
    |> Enum.reduce(fn tensor, acc -> Nx.add(acc, tensor) end)
    |> Nx.to_flat_list()
    |> Enum.filter(fn x -> x > 1 end)
    |> Enum.count()

    assert solution == 5
  end
  
  test "part2_example" do
    
    
    
  end
end
