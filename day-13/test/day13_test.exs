defmodule Day13Test do
  use ExUnit.Case
  
  test "parse input" do
    input = """
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0
      
      fold along y=7
      fold along x=5
      """
    
    instructions = Day13.parse_input(input)
    { dots, folds } = instructions
    
    assert Enum.at(dots, 4) == {10, 4}
    assert List.first(folds) == {:y, 7}
    
    paper = Day13.mark_dots(dots)
    
    { fold1_axis, fold1_line } = Enum.at(folds, 0)
    fold1 = Day13.fold_paper(paper, fold1_axis, fold1_line)
    assert Nx.to_number(Nx.sum(fold1)) == 17

    { fold2_axis, fold2_line } = Enum.at(folds, 1)
    fold2 = Day13.fold_paper(fold1, fold2_axis, fold2_line)
    assert Nx.to_number(Nx.sum(fold2)) == 16
  end


  test "custom example" do
    # """
    # #.......#
    # ........#
    # ........#
    # #........
    # ##...#..#
    # 
    # fold along y = 2
    # 
    # ##...#..#
    # #.......#
    # 
    # fold along x = 5
    # ###..
    # #.#..
    # """
    
    input = """
      0,0
      8,0
      8,1
      8,2
      0,3
      0,4
      1,4
      5,4
      8,4
      
      fold along y=2
      fold along x=5
      """
    
    instructions = Day13.parse_input(input)
    { dots, folds } = instructions
    
    assert Enum.at(dots, 4) == {0, 3}
    assert List.first(folds) == {:y, 2}
    
    paper = Day13.mark_dots(dots)
    
    { fold1_axis, fold1_line } = Enum.at(folds, 0)
    { fold2_axis, fold2_line } = Enum.at(folds, 1)
    
    assert fold1_axis == :y
    assert fold1_line == 2
    
    folded_once = Day13.fold_paper(paper, fold1_axis, fold1_line)
    folded_once_sum = Nx.sum(folded_once) |> Nx.to_number

    folded_again = Day13.fold_paper(folded_once, fold2_axis, fold2_line)
    folded_again_sum = Nx.sum(folded_again) |> Nx.to_number
        
    assert folded_once_sum == 6
    assert folded_again_sum == 5
  end
end
