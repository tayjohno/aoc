module Day15.Input exposing (..)

import Matrix exposing (Matrix)
import Parser exposing (..)


type alias Cave =
    Matrix Tile


type Tile
    = Open Creature
    | Wall


type Creature
    = Elf Stats
    | Goblin Stats
    | Empty


type alias Stats =
    { ap : Int
    , hp : Int
    }


type alias Row =
    List Tile


caveParser : Parser Cave
caveParser =
    succeed (\a -> Matrix.fromRows a Wall)
        |= Parser.loop [] caveHelper
        |. end


caveHelper : List Row -> Parser (Step (List Row) (List Row))
caveHelper rowList =
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
        |= Parser.loop [] rowHelper
        |. oneOf
            [ succeed () |. token "\n" -- end of line
            , succeed () -- end of file
            ]


rowHelper : Row -> Parser (Step Row Row)
rowHelper row =
    oneOf
        [ succeed (\tile -> Loop (tile :: row))
            |= tileParser
        , succeed ()
            |> map (\_ -> Done (List.reverse row))
        ]


tileParser : Parser Tile
tileParser =
    oneOf
        [ succeed Wall |. token "#"
        , succeed (Open Empty) |. token "."
        , succeed (Open (Goblin startingStats)) |. token "G"
        , succeed (Open (Elf startingStats)) |. token "E"
        ]


startingStats =
    { ap = 3
    , hp = 200
    }


input : Cave
input =
    let
        parsedCave =
            run caveParser rawInput
    in
    case parsedCave of
        Result.Err _ ->
            Debug.todo "Couldn't parse a map"

        Result.Ok cave ->
            cave


prettyPrintCave : Cave -> ()
prettyPrintCave =
    let
        toSym =
            \tile ->
                case tile of
                    Wall ->
                        '#'

                    Open (Goblin _) ->
                        'G'

                    Open (Elf _) ->
                        'E'

                    Open Empty ->
                        '.'
    in
    Matrix.customPrint toSym


rawInput : String
rawInput =
    """
################################
#G..#####G.#####################
##.#####...#####################
##.#######..####################
#...#####.#.#.G...#.##...###...#
##.######....#...G..#...####..##
##....#....G.........E..####.###
#####..#...G........G...##....##
######.....G............#.....##
######....G.............#....###
#####..##.......E..##.#......###
########.##...........##.....###
####G.G.......#####..E###...####
##.......G...#######..#####..###
#........#..#########.###...####
#.G..GG.###.#########.##...#####
#...........#########......#####
##..........#########..#.#######
###G.G......#########....#######
##...#.......#######.G...#######
##.......G....#####.E...#.######
###......E..G.E......E.....#####
##.#................E.#...######
#....#...................#######
#....#E........E.##.#....#######
#......###.#..#..##.#....#..####
#...########..#..####....#..####
#...########.#########......####
#...########.###################
############.###################
#########....###################
################################
    """
        |> String.trim
