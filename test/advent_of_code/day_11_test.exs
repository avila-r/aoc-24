defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  @input "125 17"
         |> AdventOfCode.Input.Day11.parse()

  test "part1", do: assert(@input |> part1 == 55312)
  test "part2", do: assert(@input |> part2 == 65_601_038_650_482)
end
