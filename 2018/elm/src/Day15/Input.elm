module Day15.Input exposing (..)

import Day15.Cave as Cave exposing (Cave, Row, Tile(..))
import Day15.Creature as Creature exposing (Class(..), Creature)
import Matrix exposing (Matrix)
import Parser exposing (..)


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
            [ succeed () |. token "\n"
            , succeed ()
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
        , succeed (Open Nothing) |. token "."
        , succeed (Open (Just (Creature.init Goblin))) |. token "G"
        , succeed (Open (Just (Creature.init Elf))) |. token "E"
        ]


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


prettyPrintCave : Cave -> Cave
prettyPrintCave cave =
    let
        toSym =
            \tile ->
                case tile of
                    Wall ->
                        '#'

                    Open (Just { class }) ->
                        case class of
                            Goblin ->
                                'G'

                            Elf ->
                                'E'

                    Open Nothing ->
                        '.'

        _ =
            Matrix.customPrint toSym cave

        _ =
            Debug.log "" (Cave.allCreatures cave)
    in
    cave
