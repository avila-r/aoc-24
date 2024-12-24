defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12

  @input """
         RRRRIICCFF
         RRRRIICCCF
         VVRRRCCFFF
         VVRCCCJFFF
         VVVVCJJCFE
         VVIVCCJJEE
         VVIIICJJEE
         MIIIIIJJEE
         MIIISIJEEE
         MMMISSJEEE
         """
         |> AdventOfCode.Input.Day12.parse()

  test "part1", do: assert(@input |> part1() == 1930)
  test "part2", do: assert(@input |> part2() == 1206)
end
