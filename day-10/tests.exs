ExUnit.start

defmodule Day10Test do
  use ExUnit.Case
  
  def example_input do
    """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
  end

  defmodule Part1 do
    use ExUnit.Case
    import Day10
    import Day10.Part1
    
    test "example1" do
      input = Day10Test.example_input()
      
      assert solve(input) == 26397
    end
  end
end