defmodule AdventOfCode.Day06 do
  def part1({guard, map}) do
    guard
    |> walk(map)
    |> MapSet.size()
  end

  defp walk(guard, map, visited \\ MapSet.new()) do
    visited = visited |> MapSet.put(elem(guard, 0))

    case to(guard, map) do
      nil -> visited
      guard -> walk(guard, map, visited)
    end
  end

  def part2({guard, map}) do
    :persistent_term.put(Day06, {guard, map})

    walk(guard, map, MapSet.new())
    |> Enum.reject(fn pos -> elem(guard, 0) === pos end)
    |> Task.async_stream(
      fn pos ->
        {guard, map} = :persistent_term.get(Day06)

        stuck?(guard, to(guard, Map.put(map, pos, ?#)), 1, 1, Map.put(map, pos, ?#))
        |> if(do: 1, else: 0)
      end,
      ordered: false,
      timeout: :infinity
    )
    |> Enum.reduce(0, fn {:ok, obstruction}, acc -> acc + obstruction end)
  end

  defp to(nil, _grid), do: nil

  defp to({pos = {a, b}, dir = {c, d}}, map) do
    to = {a + c, b + d}

    case map do
      %{^to => ?.} -> {to, dir}
      %{^to => ?\#} -> to({pos, {d, -c}}, map)
      %{} -> nil
    end
  end

  defp stuck?(_, nil, _, _, _), do: false
  defp stuck?(slow, slow, _, _, _), do: true

  defp stuck?(slow, fast, limit, count, map) do
    {slow, limit, lam} =
      if limit === count,
        do: {fast, 2 * limit, 0},
        else: {slow, limit, count}

    stuck?(slow, to(fast, map), limit, lam + 1, map)
  end
end
