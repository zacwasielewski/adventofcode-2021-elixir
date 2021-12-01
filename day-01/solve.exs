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
		pairs = Enum.chunk_every(input, 2, 1, :discard)
		Enum.count(pairs, fn [a, b] -> b > a end)
	end

	@doc """
		Group an array of integers into a sliding "window", and sum the total of each group.
	"""		
	def sum_sliding_window(input, window) do
		window = Enum.chunk_every(input, window, 1, :discard)
		Enum.map(window, fn x -> Enum.sum(x) end)
	end
		
	@doc """
		How many depth measurements are larger than the previous measurement?
	"""
	def part1 do
		count_depth_increases get_input()
	end
			
	@doc """
		Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?
	"""
	def part2 do
		windowed_input = sum_sliding_window(get_input(), 3)
		count_depth_increases(windowed_input)
	end
end

IO.puts "Part 1: #{Day1.part1}"
IO.puts "Part 2: #{Day1.part2}"
