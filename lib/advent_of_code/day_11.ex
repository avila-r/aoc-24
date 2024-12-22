defmodule AdventOfCode.Day11 do
  import Map
  import Integer

  def part1(input) do
    input
    |> blink(25)
    |> values()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> blink(75)
    |> values()
    |> Enum.sum()
  end

  defp blink(stones, 0), do: stones

  defp blink(stones, times) when is_integer(times) do
    stones
    |> to_list()
    |> blink(%{})
    |> blink(times - 1)
  end

  defp blink([], acc), do: acc
  defp blink([{0, n} | rest], acc), do: blink(rest, update(acc, 1, n, &(&1 + n)))

  defp blink([{x, n} | rest], acc) do
    blink(
      rest,
      case rem(Enum.count(digits(x)), 2) do
        0 ->
          {a, b} = Enum.split(digits(x), div(Enum.count(digits(x)), 2))

          acc
          |> update(undigits(a), n, &(&1 + n))
          |> update(undigits(b), n, &(&1 + n))

        1 ->
          update(acc, x * 2024, n, &(&1 + n))
      end
    )
  end
end
