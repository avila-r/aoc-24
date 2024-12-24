defmodule AdventOfCode.Day13 do
  def part1(input) do
    input
    |> Enum.map(fn l -> unwrap(l) |> tokens() end)
    |> Enum.flat_map(fn
      [a, b] when a <= 100 and b <= 100 -> [3 * a + b]
      _ -> []
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(fn l ->
      l
      |> then(fn _ ->
        l
        |> unwrap()
        |> then(fn [a, b, c] -> [a, b, Enum.map(c, &(&1 + 10_000_000_000_000))] end)
      end)
      |> tokens()
    end)
    |> Enum.flat_map(fn
      [a, b] -> [3 * a + b]
      _ -> []
    end)
    |> Enum.sum()
  end

  defp unwrap(line) do
    parse = fn s, c ->
      s
      |> String.split(", ")
      |> Enum.map(&(&1 |> String.split(c) |> Enum.at(1) |> String.to_integer()))
    end

    ["Button A: " <> a, "Button B: " <> b, "Prize: " <> c] =
      line |> String.split("\n")

    [parse.(a, "+"), parse.(b, "+"), parse.(c, "=")]
  end

  defp tokens([[a, c], [b, d], [e, f]]) do
    x = (d * e - b * f) / (a * d - b * c)
    y = (a * f - c * e) / (a * d - b * c)

    if floor(x) == x and floor(y) == y do
      [trunc(x), trunc(y)]
    end
  end
end
