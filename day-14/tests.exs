ExUnit.start

defmodule Day14Test do
  use ExUnit.Case
  
  defmodule Part1 do
    use ExUnit.Case
    import Day14.Part1
    
    test "example1" do
      input = """
        NNCB
        
        CH -> B
        HH -> N
        CB -> H
        NH -> C
        HB -> C
        HC -> B
        HN -> C
        NN -> C
        BH -> H
        NC -> B
        NB -> B
        BN -> B
        BB -> N
        BC -> B
        CC -> N
        CN -> C
        """
      
      %{ polymer: polymer, rules: rules } = parse_input(input)
      
      assert apply_rules("NNCB", rules) == "NCNBCHB"
      assert apply_rules("NCNBCHB", rules) == "NBCCNBBBCBHCB"
      assert apply_rules("NBCCNBBBCBHCB", rules) == "NBBBCNCCNBBNBNBBCHBHHBCHB"
      assert apply_rules("NBBBCNCCNBBNBNBBCHBHHBCHB", rules) == "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"

      assert apply_rules(polymer, rules, 4) == "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
      
      assert most_least_common_elements("NBCCNBBBCBHCB") == { {"B", 6}, {"H", 1} }

      #%{ polymer: polymer, rules: rules } = parse_input(Day14.get_input())
      #IO.inspect(apply_rules(polymer, rules, 1), printable_limit: :infinity, label: "#1:")

    end
  end
  
  defmodule Part2 do
    use ExUnit.Case
    import Day14.Part2
    
    test "example1" do
      input = """
        NNCB
        
        BB -> N
        BC -> B
        BH -> H
        BN -> B
        CB -> H
        CC -> N
        CH -> B
        CN -> C
        HB -> C
        HC -> B
        HH -> N
        HN -> C
        NB -> B
        NC -> B
        NH -> C
        NN -> C
        """
      
      %{ polymer: _, rules: rules } = Day14.Part2.parse_input(input)
      
      assert process_polymer("NNCB", rules, 1) == count_pairs("NCNBCHB")
      assert process_polymer("NNCB", rules, 2) == count_pairs("NBCCNBBBCBHCB")
      assert process_polymer("NNCB", rules, 3) == count_pairs("NBBBCNCCNBBNBNBBCHBHHBCHB")
      
      {min, max} =
        process_polymer("NNCB", rules, 10)
        |> count_elements
        |> min_max
      assert (max - min) == 1588

      {min, max} =
        process_polymer("NNCB", rules, 40)
        |> count_elements
        |> min_max
      assert (max - min) == 2188189693529

    end
  end
end