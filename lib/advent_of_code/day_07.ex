defmodule AdventOfCode.Day07 do
  def part1(input, opts \\ [concat: false]) do
    input
    |> Enum.flat_map(fn {expected, [head | tail]} ->
      if matches?(head, tail, expected, opts |> Keyword.get(:concat, false)),
        do: [expected],
        else: []
    end)
    |> Enum.sum()
  end

  defp matches?(head, [h | t], expected, concat) do
    cond do
      matches?(head + h, t, expected, concat) ->
        true

      matches?(head * h, t, expected, concat) ->
        true

      true ->
        concat and matches?(concat(head, h) + h, t, expected, concat)
    end
  end

  defp matches?(n, [], expected, _), do: n === expected

  defp concat(a, 0), do: a
  defp concat(a, b), do: concat(a * 10, div(b, 10))

  def part2(input) do
    input
    |> part1(concat: true)
  end
end
