defmodule AdventOfCode.Day08 do
  import Enum

  def part1({map, {a, b, c, d}}) do
    for {{xa, ya} = pa, l} <- map, {{xb, yb} = pb, r} <- map, l == r, pa < pb do
      [{xa - (xb - xa), ya - (yb - ya)}, {xb + (xb - xa), yb + (yb - ya)}]
    end
    |> List.flatten()
    |> uniq()
    |> filter(fn {x, y} ->
      x >= a and x <= b and
        y >= c and y <= d
    end)
    |> length()
  end

  def part2({map, {a, b, c, d}}) do
    for {{xa, ya} = pa, l} <- map, {{xb, yb} = pb, r} <- map, l == r, pa < pb do
      filter = fn {x, y} ->
        x >= a and x <= b and
          y >= c and y <= d
      end

      [
        {xb, yb}
        |> Stream.iterate(fn {x, y} -> {x + (xb - xa), y + (yb - ya)} end)
        |> take_while(&filter.(&1)),
        {xa, ya}
        |> Stream.iterate(fn {x, y} -> {x - (xb - xa), y - (yb - ya)} end)
        |> take_while(&filter.(&1))
      ]
    end
    |> List.flatten()
    |> uniq()
    |> length()
  end
end
