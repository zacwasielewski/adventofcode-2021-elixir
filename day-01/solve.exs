defmodule Day1 do
	@input_file "day-01/input.txt"
	
  defp get_input do
		{:ok, input} = File.read(@input_file)
		
		input
		|> String.split("\n", trim: true)
  end

	def reverse_and_concatenate_the_input(input) do
		input
		|> Enum.map(&String.reverse/1)
		|> Enum.join("|")
	end
	
	@doc """
		
	"""
	def part1 do
		reverse_and_concatenate_the_input get_input()
	end
end

IO.puts "Part 1: #{Day1.part1}"
