defmodule AdventOfCode.Input do
  defmodule Day01 do
    def get,
      do:
        File.read!("inputs/d01.txt")
        |> String.split("\n")
        |> Enum.reduce({[], []}, fn line, {first, second} ->
          [left, right] = String.split(line, "   ")

          {
            first ++ [String.to_integer(left)],
            second ++ [String.to_integer(right)]
          }
        end)
  end
end
