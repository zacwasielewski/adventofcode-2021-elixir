ExUnit.start

defmodule Day4Test do
  use ExUnit.Case
  import Day4
  import Day4.Part1
  
  defmodule Part1 do
    use ExUnit.Case
    import Day4
    import Day4.Part1

    @example_input """
      """
    
    test "solve" do
    end
  end

  defmodule Part2 do
    use ExUnit.Case
    import Day5
    import Day5.Part2

    @example_input """
      """
    
    test "last_winning_board" do
    end    
  end
end