defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  test "part1" do
    input =
      """
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
      """
      |> AdventOfCode.Input.Day04.parse()

    result = part1(input)

    assert result == 18
  end

  test "part2" do
    input =
      """
      .M.S......
      ..A..MSMS.
      .M.S.MAA..
      ..A.ASMSM.
      .M.S.M....
      ..........
      S.S.S.S.S.
      .A.A.A.A..
      M.M.M.M.M.
      ..........
      """
      |> AdventOfCode.Input.Day04.parse()

    result = part2(input)

    assert result == 9
  end
end
