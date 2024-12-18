defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    input =
      """
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
      """
      |> AdventOfCode.Input.Day06.parse()

    result = part1(input)

    assert result == 41
  end

  test "part2" do
    input =
      """
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
      """
      |> AdventOfCode.Input.Day06.parse()

    result = part2(input)

    result
    |> IO.inspect(label: "Result")

    assert result == 6
  end
end
