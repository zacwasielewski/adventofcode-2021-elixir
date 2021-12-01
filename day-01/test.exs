ExUnit.start

defmodule Day1Test do
  use ExUnit.Case

  test "part_1_test_1" do
  	input = [
  		"Hello there",
      "And hi to you"
  	]
  	assert Day1.reverse_and_concatenate_the_input(input) === "ereht olleH|uoy ot ih dnA"
  end
end