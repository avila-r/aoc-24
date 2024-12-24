defmodule AdventOfCode.Day14 do
  import Enum

  def part1({input, {width, height}}, times \\ 100) do
    1..times
    |> reduce(
      input
      |> map(fn line ->
        ["p=" <> p, "v=" <> v] = line |> String.split(" ")

        parse = fn pair ->
          String.split(pair, ",")
          |> map(&String.to_integer/1)
          |> List.to_tuple()
        end

        {parse.(p), parse.(v)}
      end),
      fn _, robots ->
        map(robots, fn {{a, b}, vel = {c, d}} ->
          {{Integer.mod(a + c, width), Integer.mod(b + d, height)}, vel}
        end)
      end
    )
    |> map(&elem(&1, 0))
    |> reject(fn {x, y} ->
      x === div(width, 2) or y === div(height, 2)
    end)
    |> group_by(fn {x, y} ->
      {div(x, div(width, 2) + 1), div(y, div(height, 2) + 1)}
    end)
    |> map(&elem(&1, 1))
    |> map(&length/1)
    |> product()
  end

  def part2({input, {width, height}}, iter \\ 10_000) do
    pattern =
      "*******************************"
      |> :binary.compile_pattern()

    1..iter
    |> reduce_while(
      input
      |> map(fn line ->
        ["p=" <> p, "v=" <> v] = String.split(line, " ")

        parse = fn pair ->
          String.split(pair, ",")
          |> map(&String.to_integer/1)
          |> List.to_tuple()
        end

        {parse.(p), parse.(v)}
      end),
      fn i, robots ->
        robots =
          map(robots, fn {{a, b}, vel = {c, d}} ->
            {{Integer.mod(a + c, width), Integer.mod(b + d, height)}, vel}
          end)

        grid =
          map(1..height, fn _ -> [:binary.copy(" ", width), ?\n] end)
          |> :erlang.iolist_to_binary()

        display =
          reduce(robots, grid, fn {{col, row}, _}, grid ->
            pos = row * (width + 1) + col
            <<prefix::binary-size(pos), _, suffix::binary>> = grid
            <<prefix::binary, "*", suffix::binary>>
          end)

        case :binary.match(display, pattern) do
          :nomatch -> {:cont, robots}
          _ -> {:halt, i}
        end
      end
    )
  end
end
