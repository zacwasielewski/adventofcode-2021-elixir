defmodule Day10 do
  @input_file "day-10/input.txt"

  @tags %{
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
  }

  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
  
  def is_opener?(tag) do
    Enum.member?(Map.keys(@tags), tag)
  end
  
  def is_closer?(tag) do
    Enum.member?(Map.values(@tags), tag)
  end
  
  def process_line(line) do
    initial = { nil, [] }

    String.graphemes(line)
    |> Enum.reduce_while(initial, fn tag, acc ->
      { _, stack } = acc
      
      if is_opener?(tag) do
        { :cont, { :valid, stack ++ [tag] } }
      else        
        prev_tag = List.last(stack)
        match? = tag == Map.fetch!(@tags, prev_tag)
        
        if match? do
          { :cont, { :valid, Enum.drop(stack, -1) } }
        else
          { :halt, { :corrupted, tag } } # Return first illegal character
        end
        
      end
    end)
  end
  
  def has_syntax_error?(line) do
    
  end
  
  def calculate_syntax_error_score(line) do
    
  end
end

defmodule Day10.Part1 do
  import Day10
  
  @scores %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }
  
  def solve(input) do
    lines = input |> parse_input
    lines
    |> Enum.map(fn line -> process_line(line) end)
    |> Enum.filter(fn { status, _ } -> status == :corrupted end)
    |> Enum.map(fn { _, first_illegal_char } -> Map.fetch!(@scores, first_illegal_char) end)
    |> Enum.sum
  end
end

defmodule Day10.Part2 do
  import Day10

  @tags %{
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<",
  }
  
  def matching_tag(tag) do
    Map.fetch!(@tags, tag)
  end
  
  def check_line_syntax(line) do
    initial = { nil, [] }

    { status, _} =
      String.graphemes(line)
      |> Enum.reduce_while(initial, fn tag, acc ->
        { _, stack } = acc
        
        if is_opener?(tag) do
          { :cont, { :incomplete, stack ++ [tag] } }
        else        
          prev_tag = List.last(stack)
          match? = tag == Map.fetch!(@tags, prev_tag)
          
          if match? do
            { :cont, { :incomplete, Enum.drop(stack, -1) } }
          else
            { :halt, { :corrupted, tag } } # Return first illegal character
          end
          
        end
      end)
    
    status
  end

  def complete_line(line) do
    initial = { "", [] }

    { completion, _ } =
      line
      |> String.reverse
      |> String.graphemes
      |> Enum.reduce(initial, fn tag, acc ->
        { completion, stack } = acc

        # each char:
        # is opener?
        #   does it match last on stack?
        #     y: pop last item off stack
        #     n: add matching closer to completion string
        # is closer?
        #   add to stack
        
        if is_closer?(tag) do
          { completion, stack ++ [tag] }
        else
          prev_tag = List.last(stack)
          match? = Enum.count(stack) > 0 && tag == matching_tag(prev_tag)
          
          if match? do
            { completion, Enum.drop(stack, -1) }
          else
            { completion <> matching_tag(tag), stack }
          end
          
        end        
      end)
    
    completion
  end
  
  def score_completion(completion) do
    scores = %{
      ")" => 1,
      "]" => 2,
      "}" => 3,
      ">" => 4
    }
    
    completion
    |> String.graphemes
    |> Enum.reduce(0, fn tag, score ->
      score * 5 + Map.fetch!(scores, tag)
      end)
  end
  
  def solve(input) do
    scores = 
      input
      |> parse_input
      |> Enum.filter(fn line -> check_line_syntax(line) == :incomplete end)
      |> Enum.map(&complete_line/1)
      |> Enum.map(&score_completion/1)
      |> Enum.sort
    
    middle_score = Enum.at(scores, div(length(scores), 2))
  end
end

input = Day10.get_input()
IO.puts "Part 1: #{Day10.Part1.solve(input)}"
IO.puts "Part 2: #{Day10.Part2.solve(input)}"
