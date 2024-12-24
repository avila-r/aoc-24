defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.{Input.Day15, Day15}

  @smaller """
           ########
           #..O.O.#
           ##@.O..#
           #...O..#
           #.#.O..#
           #...O..#
           #......#
           ########

           <^^>>>vv<v>>v<<
           """
           |> parse()

  @larger """
          ##########
          #..O..O.O#
          #......O.#
          #.OO..O.O#
          #..O@..O.#
          #O#..O...#
          #O..O..O.#
          #.OO.O.OO#
          #....O...#
          ##########

          <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
          vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
          ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
          <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
          ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
          ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
          >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
          <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
          ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
          v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
          """
          |> parse()

  test "part1" do
    assert part1(@smaller) == 2028
    assert part1(@larger) == 10092
  end

  test "part2" do
  end
end
