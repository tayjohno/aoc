module Day15Tests exposing (simulationTests)

import Day15 exposing (..)
import Day15.Creature exposing (..)
import Day15.Input exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (..)
import Parser
import Test exposing (..)


cave1 =
    """
#######
#E..G.#
#...#.#
#.G.#G#
#######
    """
        |> String.trim
        |> toInput


cave2 =
    """
#########
#G..G..G#
#.......#
#.......#
#G..E..G#
#.......#
#.......#
#G..G..G#
#########
   """
        |> String.trim
        |> toInput


caveNoCreatures =
    """
###
#.#
###
    """
        |> String.trim
        |> toInput


{-| The top left elf should not be able to generate a path to any of these enemies.
-}
caveNoPaths =
    """
#######
#E.#.G#
#...E.#
#....##
##...E#
#G#.EG#
#######
    """
        |> String.trim
        |> toInput


{-| The top left elf should be able to find a path through the maze
-}
caveMaze =
    """
#######
#E#...#
#.#.#.#
#.#.#.#
#.#.#.#
#...#G#
#######
    """
        |> String.trim
        |> toInput


caveTestOrdering1 =
    """
#######
#####G#
#####.#
#G....#
####E##
#######
#######
    """
        |> String.trim
        |> toInput


caveTestOrdering2 =
    """
#######
#..G..#
#.###.#
#.#...#
#...###
###E###
#######
    """
        |> String.trim
        |> toInput


problemSampleCave1 =
    """
#######
#.G...#
#...EG#
#.#.#G#
#..G#E#
#.....#
#######
    """
        |> String.trim
        |> toInput


problemSampleCave2 =
    """
#######
#G..#E#
#E#E.E#
#G.##.#
#...#E#
#...E.#
#######
    """
        |> String.trim
        |> toInput


problemSampleCave3 =
    """
#######
#E..EG#
#.#G.E#
#E.##E#
#G..#.#
#..E#.#
#######
    """
        |> String.trim
        |> toInput


problemSampleCave4 =
    """
#######
#E.G#.#
#.#G..#
#G.#.G#
#G..#.#
#...E.#
#######
    """
        |> String.trim
        |> toInput


problemSampleCave5 =
    """
#######
#.E...#
#.#..G#
#.###.#
#E#G#G#
#...#G#
#######
    """
        |> String.trim
        |> toInput


problemSampleCave6 =
    """
#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########
    """
        |> String.trim
        |> toInput


simulationTests =
    describe "simulation"
        [ describe "allCreatures"
            [ test "Should return all creatures in order (cave1)" <|
                \_ ->
                    allCreatures cave1
                        |> Expect.equalLists
                            [ ( Elf { ap = 3, hp = 200 }, ( 1, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 4, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 2, 3 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 5, 3 ) )
                            ]
            , test "Should return all creatures in order (cave2)" <|
                \_ ->
                    allCreatures cave2
                        |> Expect.equalLists
                            [ ( Goblin { ap = 3, hp = 200 }, ( 1, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 4, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 1, 4 ) )
                            , ( Elf { ap = 3, hp = 200 }, ( 4, 4 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 4 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 1, 7 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 4, 7 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 7 ) )
                            ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    allCreatures caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "allElves"
            [ test "Should return all elves in order (cave1)" <|
                \_ ->
                    allElves cave1
                        |> Expect.equalLists
                            [ ( Elf { ap = 3, hp = 200 }, ( 1, 1 ) ) ]
            , test "Should return all elves in order (cave2)" <|
                \_ ->
                    allElves cave2
                        |> Expect.equalLists
                            [ ( Elf { ap = 3, hp = 200 }, ( 4, 4 ) ) ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    allElves caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "allGoblins"
            [ test "Should return all creatures in order (cave1)" <|
                \_ ->
                    allGoblins cave1
                        |> Expect.equalLists
                            [ ( Goblin { ap = 3, hp = 200 }, ( 4, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 2, 3 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 5, 3 ) )
                            ]
            , test "Should return all creatures in order (cave2)" <|
                \_ ->
                    allGoblins cave2
                        |> Expect.equalLists
                            [ ( Goblin { ap = 3, hp = 200 }, ( 1, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 4, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 1 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 1, 4 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 4 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 1, 7 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 4, 7 ) )
                            , ( Goblin { ap = 3, hp = 200 }, ( 7, 7 ) )
                            ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    allGoblins caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "pathToNearestEnemy"
            [ test "Should handle unreachable enemies" <|
                \_ ->
                    pathToNearestEnemy caveNoPaths ( Elf startingStats, ( 1, 1 ) )
                        |> Expect.equalLists []
            , test "Should handle a maze" <|
                \_ ->
                    pathToNearestEnemy caveMaze ( Elf startingStats, ( 1, 1 ) )
                        |> Expect.equalLists [ ( 1, 2 ), ( 1, 3 ), ( 1, 4 ), ( 1, 5 ), ( 2, 5 ), ( 3, 5 ), ( 3, 4 ), ( 3, 3 ), ( 3, 2 ), ( 3, 1 ), ( 4, 1 ), ( 5, 1 ), ( 5, 2 ), ( 5, 3 ), ( 5, 4 ) ]
            , test "Should sort equal distance locations by reading order. (#1)" <|
                \_ ->
                    pathToNearestEnemy caveTestOrdering1 ( Elf startingStats, ( 4, 4 ) )
                        |> Expect.equalLists [ ( 4, 3 ), ( 5, 3 ), ( 5, 2 ) ]
            , test "Should sort equal distance locations by reading order. (#2)" <|
                \_ ->
                    pathToNearestEnemy caveTestOrdering2 ( Elf startingStats, ( 3, 5 ) )
                        |> Expect.equalLists [ ( 3, 4 ), ( 2, 4 ), ( 1, 4 ), ( 1, 3 ), ( 1, 2 ), ( 1, 1 ), ( 2, 1 ) ]
            ]
        , describe "sanityCheck"
            [ test "should solve example 1" <|
                \_ ->
                    simulateBattle 0 problemSampleCave1
                        |> Expect.equal 27730
            , test "should solve example 2" <|
                \_ ->
                    simulateBattle 0 problemSampleCave2
                        |> Expect.equal 36334
            , test "should solve example 3" <|
                \_ ->
                    simulateBattle 0 problemSampleCave3
                        |> Expect.equal 39514
            , test "should solve example 4" <|
                \_ ->
                    simulateBattle 0 problemSampleCave4
                        |> Expect.equal 27755
            , test "should solve example 5" <|
                \_ ->
                    simulateBattle 0 problemSampleCave5
                        |> Expect.equal 28944
            , test "should solve example 6" <|
                \_ ->
                    simulateBattle 0 problemSampleCave6
                        |> Expect.equal 18740
            ]
        ]


toInput i =
    let
        parsedCave =
            Parser.run caveParser i
    in
    case parsedCave of
        Result.Err _ ->
            Debug.todo "Couldn't parse a map"

        Result.Ok cave ->
            cave
