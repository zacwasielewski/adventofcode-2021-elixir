defmodule Day10 do
  @input_file "day-10/input.txt"

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end

defmodule Day10.Part1 do
  import Day10
  
  def solve(input) do
    lines = input |> parse_input
    tags = %{
      "(" => ")",
      "[" => "]",
      "{" => "}",
      "<" => ">",
    }
    scores = %{
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137,
    }
          
    Enum.map(lines, fn line ->
      
      initial = { nil, [] }
      
      String.graphemes(line)
      |> Enum.reduce_while(initial, fn x, acc ->
        
        { _, stack } = acc
        
        if String.contains?("([{<", x) do
        # if this is an opening tag
          # add it to the stack and continue
          { :cont, { :valid, stack ++ [x] } }
        else
        # if it's a closing tag:
          # does it close the last item of the stack?
          # if it's not a valid closing tag, :halt
          
          last_tag = List.last(stack)
          last_tag_match = Map.fetch!(tags, last_tag)
          
          if last_tag_match == x do
            { :cont, { :valid, Enum.drop(stack, -1) } }
          else
            { :halt, { :illegal, x } } # Return first illegal character
          end
          
        end
      end)        
    end)
    |> Enum.filter(fn { k, v } -> k == :illegal end)
    |> Enum.map(fn { k, v } -> Map.fetch!(scores, v) end)
    |> Enum.sum
  end
end

defmodule Day10.Part2 do
  import Day10

  
end

input = Day10.get_input()
IO.puts "Part 1: #{Day10.Part1.solve(input)}"
#IO.puts "Part 2: #{Day10.Part2.solve(input)}"
