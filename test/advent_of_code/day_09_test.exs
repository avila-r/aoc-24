defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  @input "2333133121414131402"
         |> AdventOfCode.Input.Day09.parse()

  test "part1", do: assert(@input |> part1() == 1928)
  test "part2", do: assert(@input |> part2() == 2858)
end
