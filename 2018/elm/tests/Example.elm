module Example exposing (suite)

import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Day09
import Day11
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


test_answer : String -> String -> (() -> Maybe String) -> Test
test_answer part expectation method =
    test part <|
        \_ ->
            Expect.equal (Just expectation) (method ())


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

        -- , describe
        --     "Day09"
        --     [ test_answer "partOne" "410375" Day09.partOne
        --     , test_answer "partTwo" "" Day09.partTwo
        --     ]
        , describe
            "Day11"
            [ test_answer "partOne" "21,41" Day11.partOne
            , test_answer "partTwo" "" Day11.partTwo
            ]
        ]
