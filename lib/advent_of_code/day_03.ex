defmodule AdventOfCode.Day03 do
  import Enum
  import String

  def part1(memory) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(memory, capture: :all_but_first)
    |> reduce(0, fn [a, b], acc ->
      acc + to_integer(a) * to_integer(b)
    end)
  end

  def part2(memory) do
    ~r/(mul)\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/
    |> Regex.scan(memory)
    |> Stream.transform(:do, fn
      ["do()"], _state ->
        {[], :do}

      ["don't()"], _state ->
        {[], :dont}

      [_, "mul", a, b], :do ->
        {[to_integer(a) * to_integer(b)], :do}

      [_, "mul", _a, _b], :dont ->
        {[], :dont}
    end)
    |> sum()
  end
end
