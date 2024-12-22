defmodule AdventOfCode.Day09 do
  import Enum

  def part1({blocks, blanks, _}) do
    {left, right} =
      split_with(
        blocks
        |> flat_map(fn {id, range} -> map(range, &{id, &1}) end),
        fn {_, index} ->
          index <
            blocks
            |> reduce(0, fn {_, range}, sum -> sum + Range.size(range) end)
        end
      )

    (left ++
       (right
        |> map(&elem(&1, 0))
        |> reverse()
        |> zip(flat_map(blanks, & &1))))
    |> reduce(0, fn {a, b}, sum -> sum + a * b end)
  end

  def part2({blocks, blanks, _}) do
    blocks
    |> reverse()
    |> reduce({blanks, 0}, fn {id, range}, {frees, checksum} ->
      {left, right} =
        split_while(frees, fn free ->
          Range.size(range) > Range.size(free) or free.first > range.first
        end)

      case right do
        [fits | rest] ->
          {occupied, remaining} = Range.split(fits, Range.size(range))

          {if(remaining.step == 1,
             do: left ++ [remaining | rest],
             else: left ++ rest
           ), checksum + id * sum(occupied)}

        [] ->
          {frees, checksum + id * sum(range)}
      end
    end)
    |> elem(1)
  end
end
