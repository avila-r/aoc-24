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

  defmodule Day02 do
    def get,
      do:
        File.read!("inputs/d02.txt")
        |> parse()

    def parse(input) do
      input
      |> String.split("\n")
      |> Enum.reduce([], fn line, acc ->
        acc ++ [line |> String.split(" ") |> Enum.map(&String.to_integer/1)]
      end)
    end
  end

  defmodule Day03 do
    def get,
      do:
        File.read!("inputs/d03.txt")
        |> parse()

    def parse(input), do: input
  end
end
