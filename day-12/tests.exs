ExUnit.start

defmodule Day12Test do
  use ExUnit.Case
  
  defmodule Part1 do
    use ExUnit.Case
    import Day12
    
    test "example1" do
      input = """
        start-A
        start-b
        A-c
        A-b
        b-d
        A-end
        b-end
        """
      
      segments = parse_input(input)      
      moves = build_moves(segments)
      paths = build_paths(moves)
      
      assert Enum.count(paths) == 10      
    end

    test "example2" do
      input = """
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc
        """

      segments = parse_input(input)      
      moves = build_moves(segments)
      paths = build_paths(moves)
      
      assert Enum.count(paths) == 19      
    end

    test "example3" do
      input = """
        fs-end
        he-DX
        fs-he
        start-DX
        pj-DX
        end-zg
        zg-sl
        zg-pj
        pj-he
        RW-he
        fs-DX
        pj-RW
        zg-RW
        start-pj
        he-WI
        zg-he
        pj-fs
        start-RW
        """

      segments = parse_input(input)      
      moves = build_moves(segments)
      paths = build_paths(moves)
      
      assert Enum.count(paths) == 226     
    end
  end
end