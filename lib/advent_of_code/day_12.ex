defmodule AdventOfCode.Day12 do
  import Enum

  defp map(input) do
    input
    |> group_by(fn {_coord, plot} -> plot end)
    |> Task.async_stream(fn {plot, list} ->
      coords = map(list, fn {coord, _plot} -> coord end)

      {plot,
       connect(coords)
       |> map(fn coords -> %{coords: coords} end)}
    end)
    |> reduce(%{}, fn {:ok, {p, r}}, acc -> Map.put(acc, p, r) end)
    |> map(fn {plot, regions} ->
      {plot,
       map(regions, fn region ->
         borders =
           reduce(region.coords, MapSet.new(), fn {r, c}, acc ->
             [
               {{0, -1}, :left},
               {{0, 1}, :right},
               {{-1, 0}, :up},
               {{1, 0}, :down}
             ]
             |> filter(fn {{offrow, offcol}, _} ->
               Map.get(input, {r + offrow, c + offcol}) != plot
             end)
             |> map(fn {{offrow, offcol}, d} ->
               {{r + offrow, c + offcol}, d}
             end)
             |> reduce(acc, fn coord, acc -> MapSet.put(acc, coord) end)
           end)

         Map.put(region, :borders, borders)
       end)}
    end)
    |> Map.new()
  end

  def part1(input) do
    input
    |> map()
    |> map(fn {plot, regions} ->
      {plot,
       map(regions, fn region ->
         %{area: MapSet.size(region.coords), border: MapSet.size(region.borders)}
       end)}
    end)
    |> Map.new()
    |> reduce(0, fn {_plot, map}, acc ->
      reduce(map, acc, fn record, acc ->
        acc + Map.fetch!(record, :border) * Map.fetch!(record, :area)
      end)
    end)
  end

  def part2(input) do
    input
    |> map()
    |> Task.async_stream(fn {plot, list} ->
      {plot,
       map(list, fn region ->
         sides =
           region.borders
           |> group_by(fn {_, dir} -> dir end)
           |> flat_map(fn {_, list} ->
             list
             |> map(fn {coord, _} -> coord end)
             |> connect()
           end)

         Map.put(region, :sides, sides)
       end)}
    end)
    |> reduce(%{}, fn {:ok, {plot, regions}}, acc -> Map.put(acc, plot, regions) end)
    |> map(fn {plot, regions} ->
      {plot,
       map(regions, fn region ->
         %{area: MapSet.size(region.coords), sides: length(region.sides)}
       end)}
    end)
    |> Map.new()
    |> reduce(0, fn {_plot, map}, acc ->
      reduce(map, acc, fn record, acc ->
        acc + Map.fetch!(record, :sides) * Map.fetch!(record, :area)
      end)
    end)
  end

  defp connect(coords), do: group([hd(coords)], tl(coords), [MapSet.new()])
  defp group([], [], l), do: l
  defp group([], coords, l), do: group([hd(coords)], tl(coords), [MapSet.new() | l])

  defp group([{row, col} | coords], rest, l) do
    {adjacent, otherwise} =
      split_with(rest, fn rest ->
        any?([{0, -1}, {0, 1}, {-1, 0}, {1, 0}], fn {offrow, offcol} ->
          rest == {row + offrow, col + offcol}
        end)
      end)

    group(adjacent ++ coords, otherwise, [
      MapSet.put(hd(l), {row, col}) | tl(l)
    ])
  end
end
