defmodule AdventOfCode.Day04 do
  import Enum

  @directions [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]

  @diagonals [
    {-1, -1},
    {-1, 1},
    {1, -1},
    {1, 1}
  ]

  def part1(input) do
    input
    |> reduce(0, fn {position, _}, acc ->
      @directions
      |> reduce(acc, fn direction, acc ->
        case matches?(input, ~c"XMAS", position, direction) do
          true -> acc + 1
          false -> acc
        end
      end)
    end)
  end

  defp matches?(grid, [expected | remaining], {row, col}, {s_row, s_col}) do
    case Map.get(grid, {row, col}) do
      ^expected -> matches?(grid, remaining, {row + s_row, col + s_col}, {s_row, s_col})
      _ -> false
    end
  end

  defp matches?(_, [], _, _), do: true

  def part2(input) do
    mas? = fn grid, {x, y}, {dx, dy} ->
      Map.get(grid, {x + dx, y + dy}) == ?M and
        Map.get(grid, {x, y}) == ?A and
        Map.get(grid, {x - dx, y - dy}) == ?S
    end

    input
    |> reduce(0, fn {position, _}, acc ->
      acc +
        (@diagonals
         |> count(fn {x, y} ->
           mas?.(input, position, {x, y}) and
             mas?.(input, position, {y, -x})
         end))
    end)
  end
end
