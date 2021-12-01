ExUnit.start

defmodule Day1Test do
  use ExUnit.Case

  test "part_1_test_1" do
  	input = [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ]
  	assert Day1.count_depth_increases(input) === 7
  end
end