defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    result = part1(input())

    assert result == 2264607
  end

  test "part2" do
    result = part2(input())

    assert result == 19457120
  end
end
