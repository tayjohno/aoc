module Day18.Input exposing (Map, Tile(..), input, prettyPrintMap, sampleInput)

import Array
import Matrix exposing (Matrix)
import Parser exposing (..)



{--

TODO: It would be nice if this map serializing/deserializing could be
reusable. (Day15 input is basically identical.) You would provide a
mapping of char to value and then it would parse out a String -> Map or
reserialize a Map -> String using that information.

--}


type Tile
    = Open
    | Tree
    | Lumberyard


type alias Map =
    Matrix Tile


input : Map
input =
    newMap rawInput


sampleInput : Map
sampleInput =
    newMap sampleRawInput


prettyPrintMap : Map -> Map
prettyPrintMap map =
    map
        |> Matrix.customPrint
            (\a ->
                case a of
                    Open ->
                        '.'

                    Tree ->
                        '|'

                    Lumberyard ->
                        '#'
            )
        |> always map


newMap : String -> Map
newMap string =
    let
        parsedMap =
            run mapParser string
    in
    case parsedMap of
        Result.Err _ ->
            Debug.todo "Couldn't parse a map"

        Result.Ok map ->
            map


mapParser : Parser Map
mapParser =
    succeed (\a -> Matrix.fromRows a Open)
        |= Parser.loop [] mapParserHelper
        |. end


mapParserHelper : List (List Tile) -> Parser (Step (List (List Tile)) (List (List Tile)))
mapParserHelper rowList =
    oneOf
        [ succeed ()
            |. end
            |> map (\_ -> Done (List.reverse rowList))
        , succeed (\row -> Loop (row :: rowList))
            |= rowParser
        ]


rowParser : Parser (List Tile)
rowParser =
    succeed identity
        |= Parser.loop [] rowParserHelper
        |. oneOf
            [ succeed () |. token "\n"
            , succeed ()
            ]


rowParserHelper : List Tile -> Parser (Step (List Tile) (List Tile))
rowParserHelper row =
    oneOf
        [ succeed (\tile -> Loop (tile :: row))
            |= tileParser
        , succeed ()
            |> map (\_ -> Done (List.reverse row))
        ]


tileParser : Parser Tile
tileParser =
    oneOf
        [ succeed Open |. token "."
        , succeed Tree |. token "|"
        , succeed Lumberyard |. token "#"
        ]


sampleRawInput =
    """
.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.
    """
        |> String.trim


rawInput =
    """
||.|..#|.|.....|..|........|..#..|#...|.........#.
...#....|#..|......#.|||...#...|...#....|.......#.
##.#|.#..|.#|....||.|#.#....#.#.###.|..|...|#.#|..
..||.#|#|#..#.#|...|....||.|...##.....|.....#...#|
#|..#...#.##|.|.##||..|...|...#||.|...#.##.###|.|.
#.#||#...#.|#.....|#.......|#.||..|..|#..#.##...#.
|.||.|.|........|.|.#.|...##.|.||..#....#..|.|#..#
....#...|#...#....|#.|.|||#.||#....||.......|.#|..
|#..#..#.|.|#.||#...|.|...|#.||...#...##....|....|
..#...|......#.#...|#...#|.|......#.|||#.|#.|#.#.|
..##.#|#|...||....##|.|||.|##|#.....#|...#...###||
...||......#...|....#.....#|#......#......#..|.|#.
..........#|.|#..|..#.##.#...#|...#..#...|...#|.||
|.#..#|###..||...|#|....|...........|...#|#.#..#|.
|.#..##.........#||.....|#|.###.#.|.....#.|..|.##.
....#||..#|...|.#...#.|.#.|..#............#.|.....
...|#...##.#.#.|.||.......#...|.....###.||...##..|
..|...|#.|.#..|..#|..||.#.....#||.|..#..|..|.||.#.
#.##||#.#.....||.|.#.......#.|.##|##|#..#|.....|#.
...#..#.#..#.|.....|.#...|.....###||||..#..##...#.
...|...|.|.##|..#.#|#....#.#.|#||||....#...|||.#.#
..|...##..|#||..||#|#..|..|##.|..##...#...#|.##.#|
|#...#.#.......|...||...##.|.||#.....#.||.......#|
..#.....#|.#...#...|.#|.#.#|.....#.##.#|.....#....
......#|..|||.#.#..||..|.|..|...##.....#..#.###...
....##..#..|..||..##.||#.|..|.#...#..||#...#..|...
.||......||#.#|#.##.||.#..|..#..#..#.|..|#|..||...
|...#|...|....|.|.|.....||.|.|..|#.#.#..|.#..##..#
..|..#..#.|.##.....|#..|..#|.|..#.#.|..|..#|..|...
....|...#..|#...#.###.|..####..||#..|.|.|......||.
.....||.#.|##|.....|##.||.##..#.#.|...#.#...||.#..
.|#..#.|...||#..|.#..#....###.#...#.....||......##
||...#||..#...##.|..|...|#.|#|.|##|#|##....#..#|..
.|..#.##..|......#|.....||..|||||||#.#.|#..|.|.|..
|#.##.|............##||##.#...#.#........|..#.....
.||....|.#||#|.#..|..........#....##.#.|...#.||..|
......|...#.......##.#.#|#......#||##...#..#||.|#.
..||.#..#.#.......|.|.##.#.|...#...###..|...|..|..
.#....|..||##.|.|..#.|.#|..#|......#....#.#.|..||.
.........|....|.#..|...|.|#....#..|.....#...|#|#.|
.|.||..|#.|...##.|.#...#..|.||||..##.##|#.##.|##.#
.|#.#.....#||#.#....||.|..##......|.#.|..#...##||.
|.#........|..|........#..#.#....|.|#.......#.|...
#..##.|.#......#...#..#.|.....#|.|.|#.##..#|...|..
..#....####....|..||...||..||.|.|...##.#..|||.||.|
...|..#.|||.||.||.#|...|..#.##..|#..........#.##|.
..|..||.#|.|.#..|.###|#.|....|.||.....|.........#.
#.|#.....#.|.#|#.|.#.#||...|.....||..|..|.##|#.|#|
..|...||#.|.#...|#.#....#.|##.#.|.....##..#..|.#..
..|.#...|.|...##|..#.#|.#|..|..#.|#.#...#|#.#||#..
    """
        |> String.trim
