module Day15Tests exposing (simulationTests)

import Day15 exposing (..)
import Day15.Cave as Cave
import Day15.Creature as Creature exposing (Class(..), Creature)
import Day15.Input as Input exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (..)
import Parser
import Test exposing (..)


onlineSample1 =
    """
#######
#######
#.E..G#
#.#####
#G#####
#######
#######
    """
        |> String.trim
        |> Input.newCave


onlineSample2 =
    """
####
#GG#
#.E#
####
    """
        |> String.trim
        |> Input.newCave


onlineSample3 =
    """
########
#..E..G#
#G######
########
    """
        |> String.trim
        |> Input.newCave


cave1 =
    """
#######
#E..G.#
#...#.#
#.G.#G#
#######
    """
        |> String.trim
        |> Input.newCave


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
        |> Input.newCave


caveNoCreatures =
    """
###
#.#
###
    """
        |> String.trim
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


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
        |> Input.newCave


simulationTests =
    describe "simulation"
        [ describe "Cave.allCreatures"
            [ test "Should return all creatures in order (cave1)" <|
                \_ ->
                    Cave.allCreatures cave1
                        |> Expect.equalLists
                            [ ( { class = Elf, ap = 3, hp = 200, startingCoordinate = ( 1, 1 ) }, ( 1, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 1 ) }, ( 4, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 2, 3 ) }, ( 2, 3 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 5, 3 ) }, ( 5, 3 ) )
                            ]
            , test "Should return all creatures in order (cave2)" <|
                \_ ->
                    Cave.allCreatures cave2
                        |> Expect.equalLists
                            [ ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 1 ) }, ( 1, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 1 ) }, ( 4, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 1 ) }, ( 7, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 4 ) }, ( 1, 4 ) )
                            , ( { class = Elf, ap = 3, hp = 200, startingCoordinate = ( 4, 4 ) }, ( 4, 4 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 4 ) }, ( 7, 4 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 7 ) }, ( 1, 7 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 7 ) }, ( 4, 7 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 7 ) }, ( 7, 7 ) )
                            ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    Cave.allCreatures caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "Cave.allElves"
            [ test "Should return all elves in order (cave1)" <|
                \_ ->
                    Cave.allElves cave1
                        |> Expect.equalLists
                            [ ( { class = Elf, ap = 3, hp = 200, startingCoordinate = ( 1, 1 ) }, ( 1, 1 ) ) ]
            , test "Should return all elves in order (cave2)" <|
                \_ ->
                    Cave.allElves cave2
                        |> Expect.equalLists
                            [ ( { class = Elf, ap = 3, hp = 200, startingCoordinate = ( 4, 4 ) }, ( 4, 4 ) ) ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    Cave.allElves caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "Cave.allGoblins"
            [ test "Should return all creatures in order (cave1)" <|
                \_ ->
                    Cave.allGoblins cave1
                        |> Expect.equalLists
                            [ ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 1 ) }, ( 4, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 2, 3 ) }, ( 2, 3 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 5, 3 ) }, ( 5, 3 ) )
                            ]
            , test "Should return all creatures in order (cave2)" <|
                \_ ->
                    Cave.allGoblins cave2
                        |> Expect.equalLists
                            [ ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 1 ) }, ( 1, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 1 ) }, ( 4, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 1 ) }, ( 7, 1 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 4 ) }, ( 1, 4 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 4 ) }, ( 7, 4 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 1, 7 ) }, ( 1, 7 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 4, 7 ) }, ( 4, 7 ) )
                            , ( { class = Goblin, ap = 3, hp = 200, startingCoordinate = ( 7, 7 ) }, ( 7, 7 ) )
                            ]
            , test "Should handle empty caves (caveNoCreatures)" <|
                \_ ->
                    Cave.allGoblins caveNoCreatures
                        |> Expect.equalLists []
            ]
        , describe "pathToNearestEnemy"
            [ test "Should handle unreachable enemies" <|
                \_ ->
                    pathToNearestEnemy caveNoPaths ( Creature.init Elf, ( 1, 1 ) )
                        |> Expect.equalLists []
            , test "Should handle a maze" <|
                \_ ->
                    pathToNearestEnemy caveMaze ( Creature.init Elf, ( 1, 1 ) )
                        |> Expect.equalLists [ ( 1, 2 ), ( 1, 3 ), ( 1, 4 ), ( 1, 5 ), ( 2, 5 ), ( 3, 5 ), ( 3, 4 ), ( 3, 3 ), ( 3, 2 ), ( 3, 1 ), ( 4, 1 ), ( 5, 1 ), ( 5, 2 ), ( 5, 3 ), ( 5, 4 ) ]
            , test "Should sort equal distance locations by reading order. (#1)" <|
                \_ ->
                    pathToNearestEnemy caveTestOrdering1 ( Creature.init Elf, ( 4, 4 ) )
                        |> Expect.equalLists [ ( 4, 3 ), ( 5, 3 ), ( 5, 2 ) ]
            , test "Should sort equal distance locations by reading order. (#2)" <|
                \_ ->
                    pathToNearestEnemy caveTestOrdering2 ( Creature.init Elf, ( 3, 5 ) )
                        |> Expect.equalLists [ ( 3, 4 ), ( 2, 4 ), ( 1, 4 ), ( 1, 3 ), ( 1, 2 ), ( 1, 1 ), ( 2, 1 ) ]
            , test "online sample 1" <|
                \_ ->
                    pathToNearestEnemy onlineSample1 ( Creature.init Elf, ( 2, 2 ) )
                        |> Expect.equalLists [ ( 3, 2 ), ( 4, 2 ) ]
            , test "online sample 2" <|
                \_ ->
                    moveCreature ( Creature.init Elf, ( 2, 2 ) ) onlineSample2
                        |> (\( ( _, newCoordinate ), _ ) -> Expect.equal ( 2, 2 ) newCoordinate)
            , test "online sample 3" <|
                \_ ->
                    pathToNearestEnemy onlineSample3 ( Creature.init Elf, ( 2, 2 ) )
                        |> Expect.equalLists [ ( 2, 1 ), ( 1, 1 ) ]
            ]
        , describe "sanityCheck"
            [ test "should solve example 1" <|
                \_ ->
                    simulateBattle 0 problemSampleCave1
                        |> .score
                        |> Expect.equal 27730
            , test "should solve example 2" <|
                \_ ->
                    simulateBattle 0 problemSampleCave2
                        |> .score
                        |> Expect.equal 36334
            , test "should solve example 3" <|
                \_ ->
                    simulateBattle 0 problemSampleCave3
                        |> .score
                        |> Expect.equal 39514
            , test "should solve example 4" <|
                \_ ->
                    simulateBattle 0 problemSampleCave4
                        |> .score
                        |> Expect.equal 27755
            , test "should solve example 5" <|
                \_ ->
                    simulateBattle 0 problemSampleCave5
                        |> .score
                        |> Expect.equal 28944
            , test "should solve example 6" <|
                \_ ->
                    simulateBattle 0 problemSampleCave6
                        |> .score
                        |> Expect.equal 18740
            , test "should simulateElvesWinning example 1" <|
                \_ ->
                    simulateElvesWinning 3 problemSampleCave1
                        |> .score
                        |> Expect.equal 4988
            , test "should simulateElvesWinning example 3" <|
                \_ ->
                    simulateElvesWinning 3 problemSampleCave3
                        |> .score
                        |> Expect.equal 31284
            , test "should simulateElvesWinning example 4" <|
                \_ ->
                    simulateElvesWinning 3 problemSampleCave4
                        |> .score
                        |> Expect.equal 3478
            , test "should simulateElvesWinning example 5" <|
                \_ ->
                    simulateElvesWinning 3 problemSampleCave5
                        |> .score
                        |> Expect.equal 6474
            , test "should simulateElvesWinning example 6" <|
                \_ ->
                    simulateElvesWinning 3 problemSampleCave6
                        |> .score
                        |> Expect.equal 1140
            ]
        ]
