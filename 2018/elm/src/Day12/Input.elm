module Day12.Input exposing (Neighbors, Planter(..), Row, Rule, input, printPlanter, printRow, printRule, ruleSet)

import Parser exposing (..)


type alias Row =
    { index : Int
    , planters : List Planter
    }


type alias Rule =
    { neighbors : Neighbors
    , output : Planter
    }


type alias Neighbors =
    { ll : Planter
    , l : Planter
    , c : Planter
    , r : Planter
    , rr : Planter
    }


type Planter
    = Plant
    | NoPlant


ruleSet : List Rule
ruleSet =
    run ruleSetParser rawRuleSet
        |> Result.withDefault []


input : Row
input =
    { index = 0
    , planters =
        rawInput
            |> run (planterRowParser |. end)
            |> Result.withDefault []
    }



{--DEBUGGING METHODS

These methods are used to validate that the program is operating as expected.

--}


printRule : Rule -> String
printRule rule =
    printPlanter rule.neighbors.ll
        ++ printPlanter rule.neighbors.l
        ++ printPlanter rule.neighbors.c
        ++ printPlanter rule.neighbors.r
        ++ printPlanter rule.neighbors.rr
        ++ " => "
        ++ printPlanter rule.output


printRow : List Planter -> String
printRow planterList =
    planterList
        |> List.map printPlanter
        |> String.join ""


printPlanter : Planter -> String
printPlanter planter =
    case planter of
        Plant ->
            "#"

        NoPlant ->
            "."



{--PARSERS

These methods are used to read the input and convert it to the defined models.

--}


{-| Parses a row of plants represented as a string
-}
planterRowParser : Parser (List Planter)
planterRowParser =
    loopHelper planterParser
        |> Parser.loop []


planterRowParserHelper : List Planter -> Parser (Step (List Planter) (List Planter))
planterRowParserHelper revPlanters =
    oneOf
        [ succeed (\planter -> Loop (planter :: revPlanters))
            |= planterParser
        , succeed ()
            |> map (\_ -> Done (List.reverse revPlanters))
        ]


planterParser : Parser Planter
planterParser =
    oneOf
        [ succeed Plant |. symbol "#"
        , succeed NoPlant |. symbol "."
        ]


ruleParser : Parser Rule
ruleParser =
    succeed Rule
        |= neighborsParser
        |. spaces
        |. keyword "=>"
        |. spaces
        |= planterParser
        |. optional (symbol "\n")


ruleSetParser : Parser (List Rule)
ruleSetParser =
    loopHelper ruleParser
        |> Parser.loop []


loopHelper : Parser a -> List a -> Parser (Step (List a) (List a))
loopHelper aParser aList =
    oneOf
        [ succeed (\rule -> Loop (rule :: aList))
            |= aParser
        , succeed ()
            |> map (\_ -> Done (List.reverse aList))
        ]


neighborsParser : Parser Neighbors
neighborsParser =
    succeed Neighbors
        |= planterParser
        |= planterParser
        |= planterParser
        |= planterParser
        |= planterParser


optional : Parser () -> Parser ()
optional parser =
    oneOf
        [ parser
        , succeed ()
        ]



{--RAW DATA

The puzzle input.

--}


{-| Input string that describes the starting pots
-}
rawInput : String
rawInput =
    "#...#..##.......####.#..###..#.##..########.#.#...#.#...###.#..###.###.#.#..#...#.#..##..#######.##"


{-| Input string that describes the rules of growth for these planters. -
-}
rawRuleSet : String
rawRuleSet =
    """
#..#. => #
#.#.. => #
###.. => #
##..# => .
.#.## => #
..... => .
...#. => #
##.#. => #
#.#.# => .
###.# => #
....# => .
####. => #
.##.. => #
#.##. => #
#..## => #
##... => #
#...# => .
##.## => #
.#... => .
.#..# => #
..#.# => #
##### => .
.#### => #
..#.. => #
#.### => .
..##. => .
.##.# => #
.#.#. => .
..### => .
.###. => .
...## => .
#.... => .
    """
        |> String.trim
