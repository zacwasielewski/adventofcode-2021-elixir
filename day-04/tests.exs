ExUnit.start

defmodule Day4Test do
  defmodule Part1 do
    use ExUnit.Case
    import Day4.Part1
    
    @example_input """
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
      
      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
      
       3 15  0  2 22
       9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6
      
      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
       2  0 12  3  7
      """
    
    test "parse_numbers" do
      %{ numbers: numbers } = parse_input(@example_input)
      assert numbers == [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
    end
    
    test "parse_boards" do
      %{ boards: boards } = parse_input(@example_input)      
      assert List.first(boards) == 
        [[22, 13, 17, 11,  0 ],
         [ 8,  2, 23,  4, 24 ],
         [21,  9, 14, 16,  7 ],
         [ 6, 10,  3, 18,  5 ],
         [ 1, 12, 20, 15, 19 ]]  
    end
    
    test "mark_board" do
      board =
        [[22, 13, 17, 11,  0 ],
         [ 8,  2, 23,  4, 24 ],
         [21,  9, 14, 16,  7 ],
         [ 6, 10,  3, 18,  5 ],
         [ 1, 12, 20, 15, 19 ]]
      marked_board =
        [[22, 13, 17, 11,  0 ],
         [ 8,  2, 23,  4, 24 ],
         [21,  9, 14, :marked, 7 ],
         [ 6, 10,  3, 18,  5 ],
         [ 1, 12, 20, 15, 19 ]]
      assert mark_board(board, 16) == marked_board
    end
    
    test "check_winning_board" do
      board =
        [[22, 13, 17, 11,  0 ],
         [ 8,  2, 23,  4, 24 ],
         [21,  9, 14, 16,  7 ],
         [ 6, 10,  3, 18,  5 ],
         [ 1, 12, 20, 15, 19 ]]

      losing_board = board
      |> mark_board(13)
      |> mark_board(2)

      winning_board = board
      |> mark_board(13)
      |> mark_board(2)
      |> mark_board(9)
      |> mark_board(10)
      |> mark_board(12)
      
      assert winning_board?(losing_board) == false
      assert winning_board?(winning_board) == true
    end
    
    test "sum_board" do
      board =
        [[14, 21, 17, 24,  4 ],
         [10, 16, 15,  9, 19 ],
         [18,  8, 23, 26, 20 ],
         [22, 11, 13,  6,  5 ],
         [ 2,  0, 12,  3,  7 ]]
      sum = board
      |> mark_board(7)
      |> mark_board(4)
      |> mark_board(9)
      |> mark_board(5)
      |> mark_board(11)
      |> mark_board(17)
      |> mark_board(23)
      |> mark_board(2)
      |> mark_board(0)
      |> mark_board(14)
      |> mark_board(21)
      |> mark_board(24)
      |> sum_board
      
      assert sum == 188
    end
    
    test "solve" do
      %{ boards: boards, numbers: numbers } = parse_input(@example_input)      
      %{ number: winning_number, board: winning_board } = play_bingo(boards, numbers)

      assert 4512 == calculate_winning_score(winning_board, winning_number)      
    end
  end
end