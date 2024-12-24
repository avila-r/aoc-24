defmodule AdventOfCode.Day15 do
  def part1({warehouse, list}) do
    {{map, start}, moves} = {
      warehouse
      |> String.split("\n")
      |> Stream.with_index()
      |> Enum.reduce({%{}, nil}, fn {line, x}, {map, pos} ->
        line
        |> String.codepoints()
        |> Stream.with_index()
        |> Enum.reduce({map, pos}, fn
          {e, y}, {map, nil} when e == "@" -> {map, {x, y}}
          {e, _y}, acc when e == "." -> acc
          {e, y}, {map, nil} -> {Map.put(map, {x, y}, e), nil}
          {e, y}, {m, pos} -> {Map.put(m, {x, y}, e), pos}
        end)
      end),
      list
      |> String.split("\n")
      |> Enum.reduce([], fn line, acc ->
        Enum.reduce(String.codepoints(line), acc, fn e, acc -> [e | acc] end)
      end)
      |> Enum.reverse()
    }

    moves
    |> Enum.reduce({start, map}, &move(&2, &1))
    |> elem(1)
    |> Map.to_list()
    |> Enum.filter(fn {{_x, _y}, e} -> e == "O" end)
    |> Enum.reduce(0, fn {{x, y}, _}, acc ->
      acc + x * 100 + y
    end)
  end

  defp move({pos = {x, y}, map}, s) do
    case check(pos, s, map, []) do
      {:error, :stuck} ->
        {pos, map}

      {:ok, boxes} ->
        {
          case s do
            ">" -> {x, y + 1}
            "<" -> {x, y - 1}
            "v" -> {x + 1, y}
            "^" -> {x - 1, y}
          end,
          Enum.reduce(boxes, map, fn box_pos = {x, y}, map ->
            {box, map} = Map.pop!(map, box_pos)

            next =
              case s do
                ">" -> {x, y + 1}
                "<" -> {x, y - 1}
                "v" -> {x + 1, y}
                "^" -> {x - 1, y}
              end

            Map.put(map, next, box)
          end)
        }
    end
  end

  defp check({x, y}, s, map, acc) do
    next =
      case s do
        ">" -> {x, y + 1}
        "<" -> {x, y - 1}
        "v" -> {x + 1, y}
        "^" -> {x - 1, y}
      end

    case Map.get(map, next) do
      nil -> {:ok, acc}
      "O" -> check(next, s, map, [next | acc])
      "[" -> checkp({x, y}, {x, y + 1}, s, map, acc)
      "]" -> checkp({x, y}, {x, y - 1}, s, map, acc)
      "#" -> {:error, :stuck}
    end
  end

  defp checkp(pos, p, s, map, acc) when s in ["^", "v"] do
    with {:ok, accr} <- check(pos, s, map, [pos | acc]),
         {:ok, acc} <- check(p, s, map, [p | accr]) do
      {:ok, Enum.uniq(acc)}
    end
  end

  defp checkp(pos, _p, s, map, acc),
    do: check(pos, s, map, [pos | acc])

  def part2(_args) do
  end
end
