defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  @input """
         89010123
         78121874
         87430965
         96549874
         45678903
         32019012
         01329801
         10456732
         """
         |> AdventOfCode.Input.Day10.parse()

  test "part1", do: assert(@input |> part1() == 36)
  test "part2", do: assert(@input |> part2() == 81)
end
