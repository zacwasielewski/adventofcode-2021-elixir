defmodule Day5 do
  @input_file "day-05/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
  end
end

defmodule Day5.Part1 do
  import Day5
    
  def solve(input) do    
  end
end

#input = Day5.get_input()
#IO.puts "Part 1: #{Day5.Part1.solve(input)}"
#IO.puts "Part 2: #{Day5.Part2.solve(input)}"
