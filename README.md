# Advent of Code within Elixir!

**Structure:**

There are 25 modules, 25 tests, and 50 mix tasks.

1. Tests filled with example solutions.
2. Solutions can be executed by `mix d01.p1`!
    - Benchmark your solution by passing the `-b` flag, `mix d01.p1 -b`

```elixir
defmodule AdventOfCode.Day01 do
  def part1(input) do
  end

  def part2(input) do
  end
end
```

```elixir
defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    input = nil
    result = part1(input)

    assert result
  end

  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
```

```elixir
defmodule Mix.Tasks.D01.P1 do
  use Mix.Task

  import AdventOfCode.Day01

  @shortdoc "Day 01 Part 1"
  def run(args) do
    input = AdventOfCode.Input.Day01.get()

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
```
