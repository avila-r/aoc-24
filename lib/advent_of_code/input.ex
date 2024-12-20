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

  defmodule Day04 do
    def get do
      File.read!("inputs/d04.txt")
      |> parse()
    end

    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, col}, acc ->
          Map.put(acc, {row, col}, String.to_charlist(char) |> hd())
        end)
      end)
    end
  end

  defmodule Day05 do
    def get do
      File.read!("inputs/d05.txt")
      |> parse()
    end

    def parse(input) do
      [up, down] = String.split(input, "\n\n", parts: 2)

      rules =
        up
        |> String.split("\n")
        |> Enum.map(fn line ->
          line
          |> String.split("|")
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()
        end)

      updates =
        down
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          line
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
        end)

      {rules, updates}
    end
  end

  defmodule Day06 do
    def get do
      File.read!("inputs/d06.txt")
      |> parse()
    end

    def parse(input) do
      positions =
        input
        |> String.trim()
        |> String.split("\n")
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {i, j}, acc ->
          i
          |> String.to_charlist()
          |> Enum.with_index()
          |> Enum.reduce(acc, fn {char, col}, acc ->
            Map.put(acc, {j, col}, char)
          end)
        end)

      positions
      |> Enum.find(fn {_, c} -> c === ?^ end)
      |> then(fn {{row, col}, _} ->
        {{{row, col}, {-1, 0}}, Map.put(positions, {row, col}, ?.)}
      end)
    end
  end

  defmodule Day07 do
    def get do
      File.read!("inputs/d07.txt")
      |> parse()
    end

    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [head, tail] = String.split(line, ": ", parts: 2)

        expected =
          head
          |> String.to_integer()

        equation =
          tail
          |> String.split(" ")
          |> Enum.map(&String.to_integer/1)

        {expected, equation}
      end)
    end
  end

  defmodule Day08 do
    def get do
      File.read!("inputs/d08.txt")
      |> parse()
    end

    def parse(input) do
      lines =
        input
        |> String.split("\n", trim: true)

      grid =
        for {line, y} <- lines |> Enum.with_index(),
            {char, x} <- line |> String.graphemes() |> Enum.with_index(),
            char != ".",
            into: %{} do
          {{x, y}, char}
        end

      bounds = {
        0,
        String.length(hd(lines)) - 1,
        0,
        Enum.count(lines) - 1
      }

      {grid, bounds}
    end
  end
end
