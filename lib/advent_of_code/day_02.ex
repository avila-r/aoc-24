defmodule AdventOfCode.Day02 do
  import Enum

  def part1(input) do
    input
    |> filter(&safe?/1)
    |> count()
  end

  def part2(input) do
    IO.inspect(input)

    input
    |> filter(fn report ->
      safe?(report) or
        any?(0..(length(report) - 1), fn i ->
          report
          |> List.delete_at(i)
          |> safe?()
        end)
    end)
    |> count()
  end

  defp safe?(report) do
    (sort(report) == report or
       sort(report, :desc) == report) and
      report
      |> chunk_every(2, 1, :discard)
      |> all?(fn [a, b] -> abs(a - b) in 1..3 end)
  end
end
