defmodule AdventOfCode.Day01 do
  import Enum

  def input do
    File.read!("inputs/d01.txt")
    |> String.split("\n")
    |> reduce({[], []}, fn line, {first, second} ->
      [left, right] = String.split(line, "   ")

      {
        first ++ [String.to_integer(left)],
        second ++ [String.to_integer(right)]
      }
    end)
  end

  def part1(input) do
    input
    |> then(fn {left, right} ->
      zip(sort(left), sort(right))
    end)
    |> reduce(0, fn {a, b}, d -> d + abs(a - b) end)
  end

  def part2({left, right}) do
    frequencies =
      right
      |> frequencies()

    left
    |> reduce(0, fn n, acc ->
      acc + n * Map.get(frequencies, n, 0)
    end)
  end
end
