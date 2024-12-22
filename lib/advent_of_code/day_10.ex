defmodule AdventOfCode.Day10 do
  import Enum

  def part1(map) do
    map
    |> filter(fn {_, h} -> h === 0 end)
    |> map(fn {position, 0} -> goals(map, position, 1) end)
    |> map(fn goal -> goal |> uniq() |> count() end)
    |> sum()
  end

  def part2(map) do
    map
    |> filter(fn {_, height} -> height === 0 end)
    |> map(fn {position, 0} -> goals(map, position, 1) end)
    |> map(&count/1)
    |> sum()
  end

  defp goals(map, {r, c}, h) do
    [{r - 1, c}, {r, c - 1}, {r, c + 1}, {r + 1, c}]
    |> flat_map(fn n ->
      case map do
        %{^n => 9} when h === 9 -> [n]
        %{^n => ^h} -> goals(map, n, h + 1)
        %{} -> []
      end
    end)
  end
end
