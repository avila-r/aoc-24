# Advent of Code within Elixir!

**Structure:**

There are 25 modules, 25 tests, and 50 mix tasks.

1. Tests filled with example solutions.
2. Solutions can be executed by `mix d01.p1`!
    - Benchmark the solution by passing the `-b` flag, `mix d01.p1 -b`

```elixir
defmodule AdventOfCode.DayX do
  def part1(input) do
  end

  def part2(input) do
  end
end
```

```elixir
defmodule AdventOfCode.DayXTest do
  use ExUnit.Case

  import AdventOfCode.DayX

  @input """
         ?
         """
         |> AdventOfCode.Input.DayX.parse()

  test "part1", do: assert(part1(@input) == ?)
  test "part2", do: assert(part2(@input) == ?)
end
```

```elixir
defmodule Mix.Tasks.DX.P1 do
  use Mix.Task

  import AdventOfCode.DayX

  @shortdoc "Day X Part 1"
  def run(args) do
    input = AdventOfCode.Input.DayX.get()

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
```
