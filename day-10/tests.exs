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
    import Day10.Part1
    
    test "example1" do
      input = Day10Test.example_input()
      
      assert solve(input) == 26397
    end
  end
  
  defmodule Part2 do
    use ExUnit.Case
    import Day10
    import Day10.Part2
    
    test "complete_line" do
      line = "[({(<(())[]>[[{[]{<()<>>"

      assert complete_line(line) == "}}]])})]"
    end
    
    test "score_completion" do
      assert score_completion("}}]])})]") == 288957
      assert score_completion(")}>]})") == 5566
      assert score_completion("}}>}>))))") == 1480781
    end
    
    test "example1" do
      lines = Day10Test.example_input() |> parse_input
    
      scores = 
        lines
        |> Enum.filter(fn line -> check_line_syntax(line) == :incomplete end)
        |> Enum.map(&complete_line/1)
        |> Enum.map(&score_completion/1)
        |> Enum.sort
      
      middle_score = Enum.at(scores, div(length(scores), 2))
      
      assert middle_score == 288957
    end
  end
end