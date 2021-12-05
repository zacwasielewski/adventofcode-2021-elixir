defmodule Day05Test do
  use ExUnit.Case
  doctest Day05
  
  import Day05
  
  test "create_tensor" do
    base_tensor = Nx.broadcast(0, {9, 9})
    
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
    
    line_defs = parse_input(input)
    
    tensors = line_defs
    |> Enum.filter(&is_orthogonal?/1)
    |> Enum.map(fn line ->
        [startpoint, endpoint] = line
        
        x = Enum.at(endpoint, 0) - Enum.at(startpoint, 0)
        y = Enum.at(endpoint, 1) - Enum.at(startpoint, 1)
        
        #segment = cond do
        #  x !== 0 -> List.duplicate(1, x)
        #  y !== 0 -> List.duplicate(1, y)
        #end
        
        slice = cond do
          y !== 0 -> Nx.tensor([[1, 1, 1, 1]])
          x !== 0 -> Nx.transpose(Nx.tensor([[1, 1, 1, 1]]))
        end

        Nx.put_slice(base_tensor, startpoint, slice)
      end)
    |> IO.inspect
    
    tensors
    |> Enum.reduce(&Nx.add/2)
    |> IO.inspect
    
    #tensor = Nx.broadcast(0, {9, 9})
    #t1 = Nx.put_slice(tensor, [1, 2], Nx.tensor([[1, 1, 1, 1]]))
    #t2 = Nx.put_slice(tensor, [1, 5], Nx.transpose(Nx.tensor([[1, 1, 1, 1]])))
    
    #IO.inspect t1
    #IO.inspect t2
    
    #IO.inspect Nx.add(t1, t2)
    
    #
    #t1 = Nx.put_slice(tensor, [1, 2], Nx.tensor([[7, 8], [9, 10]]))
    #
    #IO.inspect o
  end
end
