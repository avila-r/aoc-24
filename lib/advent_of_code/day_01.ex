defmodule AdventOfCode.Day01 do
  def input do
    File.read!("inputs/d01.txt")
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn line, {first, second} ->
      [left, right] = String.split(line, "   ")

      {
        first ++ [String.to_integer(left)],
        second ++ [String.to_integer(right)]
      }
    end)
  end

  import Enum

  def part1(input) do
    input
    |> then(fn {left, right} ->
      zip(sort(left), sort(right))
    end)
    |> reduce(0, fn {a, b}, d -> d + abs(a - b) end)
  end

  def part2({left, right}) do
    left
    |> reduce(0, fn n, acc ->
      acc + n * Map.get(frequencies(right), n, 0)
    end)
  end
end
