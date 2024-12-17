defmodule AdventOfCode.Day05 do
  import Enum

  def part1({rules, updates}) do
    updates
    |> filter(&valid?(&1, rules))
    |> map(&at(&1, div(length(&1), 2)))
    |> sum()
  end

  defp valid?([_], _), do: true

  defp valid?([head | tail], rules),
    do: all?(tail, fn right -> {head, right} in rules end) and valid?(tail, rules)

  def part2({rules, updates}) do
    updates
    |> filter(&(not valid?(&1, rules)))
    |> map(&reduce(&1, [], fn current, ordered -> set(ordered, current, rules) end))
    |> map(&at(&1, div(length(&1), 2)))
    |> sum()
  end

  defp set([head | tail], current, rules) do
    if {head, current} in rules,
      do: [head | set(tail, current, rules)],
      else: [current, head | tail]
  end

  defp set([], current, _), do: [current]
end
