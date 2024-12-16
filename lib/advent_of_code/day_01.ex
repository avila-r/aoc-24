defmodule AdventOfCode.Day01 do
  import Enum

  def part1({left, right}) do
    zip(sort(left), sort(right))
    |> reduce(0, fn {a, b}, d -> d + abs(a - b) end)
  end

  def part2({left, right}) do
    frequencies = frequencies(right)

    left
    |> reduce(0, fn n, acc ->
      acc + n * Map.get(frequencies, n, 0)
    end)
  end
end
