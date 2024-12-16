defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input =
      AdventOfCode.Input.Day02.parse(
        "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"
      )

    result = part1(input)

    assert result == 2
  end

  test "part2" do
    input =
      AdventOfCode.Input.Day02.parse(
        "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"
      )

    result = part2(input)

    assert result == 4
  end
end
