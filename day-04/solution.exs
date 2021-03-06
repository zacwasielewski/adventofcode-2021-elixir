defmodule Day4 do
  @input_file "day-04/input.txt"
  
  def get_input do
    {:ok, input} = File.read(@input_file)
    input
  end
  
  def parse_input(input) do
    [ head | tail ] = String.split(input, "\n\n", trim: true)
    %{ numbers: parse_numbers(head), boards: parse_boards(tail) }
  end
  
  def parse_numbers(input) do
    input |> String.split(",") |> Enum.map(&String.to_integer/1)
  end
  
  def parse_board(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x) |> Enum.map(&String.to_integer/1) end)
  end
  
  def parse_boards(input) do
    input |> Enum.map(&parse_board/1)
  end
  
  def mark_board(board, number) do
    board
    |> Enum.map(fn row ->
        Enum.map(row, fn cell ->
          if cell == number, do: :marked, else: cell
        end)
      end)
  end
    
  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
  
  def winning_board?(board) do
    winning_rows? = board
    |> Enum.any?(fn row ->
      Enum.all?(row, fn cell -> cell == :marked end)
    end)
    
    winning_cols? = transpose(board)
    |> Enum.any?(fn col ->
      Enum.all?(col, fn cell -> cell == :marked end)
    end)
    
    winning_rows? || winning_cols?
  end
  
  def sum_board(board) do
    board
    |> Enum.map(fn row ->
        row
        |> Enum.filter(&Kernel.is_number/1)
        |> Enum.sum    
      end)
    |> Enum.sum
  end
  
  def calculate_score(board, final_number) do
    sum_board(board) * final_number
  end
end

defmodule Day4.Part1 do
  import Day4

  def first_winning_board(boards, numbers) do    
    numbers
    |> Enum.reduce_while(boards, fn number, acc ->
        marked_boards = Enum.map(acc, fn board -> mark_board(board, number) end)
        winning_board = Enum.filter(marked_boards, &winning_board?/1) |> Enum.at(0)
        
        if winning_board do
          {:halt, %{ number: number, board: winning_board }}
        else
          {:cont, marked_boards}
        end
      end)
  end
    
  def solve(input) do    
    %{ boards: boards, numbers: numbers } = parse_input(input)      
    %{ number: winning_number, board: winning_board } = first_winning_board(boards, numbers)

    calculate_score(winning_board, winning_number)      
  end
end

defmodule Day4.Part2 do
  import Day4

  def winning_boards(boards, numbers) do
    initial = %{ boards: boards, number: nil, winning_boards: [] }
    
    numbers
    |> Enum.reduce(initial, fn number, acc ->
        %{ boards: boards, winning_boards: winning_boards } = acc
        
        new_winning_boards = boards
        |> Enum.map(fn board ->
            marked = mark_board(board, number)
            if !winning_board?(board) && winning_board?(marked), do: %{ board: marked, number: number }, else: nil
          end)

        marked = Enum.map(boards, fn x -> mark_board(x, number) end)
          
        %{ acc |
          boards: marked,
          winning_boards: Enum.reject(winning_boards ++ new_winning_boards, &is_nil/1)
        }
      end)
      |> Map.fetch!(:winning_boards)
  end
  
  def solve(input) do    
    %{ boards: boards, numbers: numbers } = parse_input(input)      
    
    winning_boards = winning_boards(boards, numbers)
    %{ board: last_winning_board, number: last_winning_number } = Enum.at(winning_boards, -1)

    calculate_score(last_winning_board, last_winning_number)
  end
end

input = Day4.get_input()
IO.puts "Part 1: #{Day4.Part1.solve(input)}"
IO.puts "Part 2: #{Day4.Part2.solve(input)}"
