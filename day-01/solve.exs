defmodule Day1 do
	@input_file "day-01/input.txt"
	
  defp get_input do
		{:ok, input} = File.read(@input_file)
		
		input
		|> String.split("\n", trim: true)
		|> Enum.map(&String.to_integer/1)
  end

	
	def count_depth_increases(input) do
		pairs = Enum.chunk_every(input, 2, 1, :discard)
		Enum.count(pairs, fn [a, b] -> b > a end)
	end
	
	@doc """
		How many measurements are larger than the previous measurement?
	"""
	def part1 do
		count_depth_increases get_input()
	end
end

IO.puts "Part 1: #{Day1.part1}"
