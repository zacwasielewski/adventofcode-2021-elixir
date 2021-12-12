ExUnit.start

defmodule Day11Test do
  use ExUnit.Case
  
  def example_input do
    """
    11111
    19991
    19191
    19991
    11111
    """
  end

  defmodule Part1 do
    use ExUnit.Case
    import Day11
    
    test "example1" do
      matrix = Day11Test.example_input() |> to_matrix
      
      step1 = """
        34543
        40004
        50005
        40004
        34543
        """
      
      step2 = """
        45654
        51115
        61116
        51115
        45654
        """
      
      assert step(matrix) == to_matrix(step1)      
      assert to_matrix(step2) ==
        Enum.reduce(1..2, matrix, fn _, acc -> step(acc) end)
    end

    test "example2" do
      input = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """

      matrix = input |> to_matrix
      
      step1 = """
        6594254334
        3856965822
        6375667284
        7252447257
        7468496589
        5278635756
        3287952832
        7993992245
        5957959665
        6394862637
        """
      
      step2 = """
        8807476555
        5089087054
        8597889608
        8485769600
        8700908800
        6600088989
        6800005943
        0000007456
        9000000876
        8700006848
        """
        
      step20 = """
        3936556452
        5686556806
        4496555690
        4448655580
        4456865570
        5680086577
        7000009896
        0000000344
        6000000364
        4600009543
        """
      
      assert step(matrix) == to_matrix(step1)      
      assert to_matrix(step1) ==
        Enum.reduce(1..1, matrix, fn _, acc -> step(acc) end)

      assert to_matrix(step2) ==
        Enum.reduce(1..2, matrix, fn _, acc -> step(acc) end)

      assert to_matrix(step20) ==
        Enum.reduce(1..20, matrix, fn _, acc -> step(acc) end)
    end

    test "example3" do
      input = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """

      matrix = input |> to_matrix
      initial = { matrix, 0 }
      
      { _, flashes } = Enum.reduce(1..10, initial, fn _, acc -> step_with_flashes(acc) end)
      assert flashes == 204
    end
  end

  defmodule Part2 do
    use ExUnit.Case
    import Day11
    
    test "is_synced" do
      not_synced = """
        6988888888
        9988888888
        8888888888
        8888888888
        8888888888
        8888888888
        8888888888
        8888888888
        8888888888
        8888888888
        """ |> to_matrix
      synced = """
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        0000000000
        """ |> to_matrix

      assert flashing_simultaneously?(not_synced) == false
      assert flashing_simultaneously?(synced) == true
    end

    test "example" do
      input_matrix = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """ |> to_matrix
      
      step193_test = """
        5877777777
        8877777777
        7777777777
        7777777777
        7777777777
        7777777777
        7777777777
        7777777777
        7777777777
        7777777777
        """ |> to_matrix
  
      input_metadata = %{ flashes: 0 }
      initial = {
        input_matrix,
        input_metadata
      }
      
      { step193, _ } = Enum.reduce(1..193, initial, fn _, acc -> Day11.Part2.step(acc) end)
      assert step193 == step193_test
      
      assert Day11.Part2.first_simultaneous_flash(initial) == 195
    end
  end
end