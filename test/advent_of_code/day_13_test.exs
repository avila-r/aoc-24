defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13

  defp input do
    File.read!("inputs/d13.test.txt")
    |> AdventOfCode.Input.Day13.parse()
  end

  test "part1", do: assert(input() |> part1() == 480)
  test "part2", do: assert(input() |> part2() == 875_318_608_908)
end
