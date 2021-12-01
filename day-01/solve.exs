defmodule Day1 do
	@input_file "day-01/input.txt"
	
  defp get_input do
		{:ok, input} = File.read(@input_file)
		
		input
		|> String.split("\n", trim: true)
		|> Enum.map(&String.to_integer/1)
  end
	
	@doc """
		Given an array of integer depth values, count the number of times a depth measurement increases from the previous measurement.
	"""
	def count_depth_increases(input) do
		input
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.count(fn [a, b] -> b > a end)
	end

	@doc """
		Group an array of integers into a sliding "window", and sum the total of each group.
	"""		
	def sum_sliding_window(input, window_length) do
		input
		|> Enum.chunk_every(window_length, 1, :discard)
		|> Enum.map(fn x -> Enum.sum(x) end)
	end
		
	@doc """
		How many depth measurements are larger than the previous measurement?
	"""
	def part1 do
		get_input()
		|> count_depth_increases()
	end
			
	@doc """
		Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?
	"""
	def part2 do
		get_input()
		|> sum_sliding_window(3)
		|> count_depth_increases()
	end
end

IO.puts "Part 1: #{Day1.part1}"
IO.puts "Part 2: #{Day1.part2}"
