defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    result = part1(AdventOfCode.Input.Day01.get())

    assert result == 2_264_607
  end

  test "part2" do
    result = part2(AdventOfCode.Input.Day01.get())

    assert result == 19_457_120
  end
end
