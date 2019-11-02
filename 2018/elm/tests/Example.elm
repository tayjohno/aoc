module Example exposing (suite)

import Answer exposing (Answer(..))
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Day09
import Day10
import Day11
import Day12
import Day13
import Day14
import Day15
import Day16
import Day17
import Day18
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


test_answer : String -> String -> (() -> Answer String) -> Test
test_answer part expectation method =
    test part <|
        \_ ->
            Expect.equal (Solved expectation) (method ())


suite : Test
suite =
    describe "Advent of Code"
        [ describe "Day01"
            [ test_answer "partOne" "569" Day01.partOne
            , test_answer "partTwo" "77666" Day01.partTwo
            ]
        , describe
            "Day02"
            [ test_answer "partOne" "7470" Day02.partOne
            , test_answer "partTwo" "kqzxdenujwcstybmgvyiofrrd" Day02.partTwo
            ]
        , describe
            "Day03"
            [ test_answer "partOne" "101469" Day03.partOne
            , test_answer "partTwo" "1067" Day03.partTwo
            ]
        , describe
            "Day04"
            [ test_answer "partOne" "39698" Day04.partOne
            , test_answer "partTwo" "14920" Day04.partTwo
            ]
        , describe
            "Day05"
            [ test_answer "partOne" "9686" Day05.partOne
            , test_answer "partTwo" "5524" Day05.partTwo
            ]
        , describe
            "Day06"
            [ test_answer "partOne" "4342" Day06.partOne
            , test_answer "partTwo" "42966" Day06.partTwo
            ]
        , describe
            "Day07"
            [ test_answer "partOne" "GJKLDFNPTMQXIYHUVREOZSAWCB" Day07.partOne
            , test_answer "partTwo" "967" Day07.partTwo
            ]
        , describe
            "Day08"
            [ test_answer "partOne" "42254" Day08.partOne
            , test_answer "partTwo" "25007" Day08.partTwo
            ]
        , describe
            "Day09"
            [ test_answer "partOne" "410375" Day09.partOne
            , test_answer "partTwo" "" Day09.partTwo
            ]
        , describe
            "Day10"
            [ test_answer "partOne" "AHFGRKEE" Day10.partOne
            , test_answer "partTwo" "" Day10.partTwo
            ]
        , describe
            "Day11"
            [ test_answer "partOne" "21,41" Day11.partOne
            , test_answer "partTwo" "" Day11.partTwo
            ]
        , describe
            "Day12"
            [ test_answer "partOne" "4217" Day12.partOne
            , test_answer "partTwo" "4550000002111" Day12.partTwo
            ]
        , describe
            "Day13"
            [ test_answer "partOne" "82,104" Day13.partOne
            , test_answer "partTwo" "121,22" Day13.partTwo
            ]
        , describe
            "Day14"
            [ test_answer "partOne" "5115114101" Day14.partOne
            , test_answer "partTwo" "20310465" Day14.partTwo
            ]
        , describe
            "Day15"
            [ test_answer "partOne" "206720" Day15.partOne
            , test_answer "partTwo" "37992" Day15.partTwo
            ]
        , describe
            "Day16"
            [ test_answer "partOne" "531" Day16.partOne
            , test_answer "partTwo" "649" Day16.partTwo
            ]
        , describe
            "Day17"
            [ test_answer "partOne" "40879" Day17.partOne
            , test_answer "partTwo" "34693" Day17.partTwo
            ]
        , describe
            "Day18"
            [ test_answer "partOne" "486878" Day18.partOne
            , test_answer "partTwo" "190836" Day18.partTwo
            ]
        ]
