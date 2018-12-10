module Day06.Input exposing (input)

import Matrix exposing (Coordinate)
import Parser exposing ((|.), (|=), Parser, int, run, spaces, succeed, symbol)


input : List Coordinate
input =
    String.split "\n" rawInput
        |> List.map (run coordinateParser)
        |> List.map Result.toMaybe
        |> List.filterMap identity


coordinateParser : Parser Coordinate
coordinateParser =
    succeed (\a b -> ( a, b ))
        |= int
        |. symbol ","
        |. spaces
        |= int


rawInput : String
rawInput =
    "156, 193\n81, 315\n50, 197\n84, 234\n124, 162\n339, 345\n259, 146\n240, 350\n97, 310\n202, 119\n188, 331\n199, 211\n117, 348\n350, 169\n131, 355\n71, 107\n214, 232\n312, 282\n131, 108\n224, 103\n83, 122\n352, 142\n208, 203\n319, 217\n224, 207\n327, 174\n89, 332\n254, 181\n113, 117\n120, 161\n322, 43\n115, 226\n324, 222\n151, 240\n248, 184\n207, 136\n41, 169\n63, 78\n286, 43\n84, 222\n81, 167\n128, 192\n127, 346\n213, 102\n313, 319\n207, 134\n154, 253\n50, 313\n160, 330\n332, 163"
