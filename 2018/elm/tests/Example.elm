module Example exposing (suite)

import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "Advent of Code"
        [ describe "Day01"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "569") Day01.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "77666") Day01.partTwo
            ]
        , describe
            "Day02"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "7470") Day02.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "kqzxdenujwcstybmgvyiofrrd") Day02.partTwo
            ]
        , describe
            "Day03"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "101469") Day03.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "1067") Day03.partTwo
            ]
        , describe
            "Day04"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "39698") Day04.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "14920") Day04.partTwo
            ]
        , describe
            "Day05"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "9686") Day05.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "5524") Day05.partTwo
            ]
        , describe
            "Day06"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "4342") Day06.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "42966") Day06.partTwo
            ]
        , describe
            "Day07"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "GJKLDFNPTMQXIYHUVREOZSAWCB") Day07.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "967") Day07.partTwo
            ]
        , describe
            "Day08"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "42254") Day08.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "25007") Day08.partTwo
            ]
        , describe
            "Day09"
            [ test "partOne" <|
                \_ ->
                    Expect.equal (Just "410375") Day08.partOne
            , test "partTwo" <|
                \_ ->
                    Expect.equal (Just "") Day08.partTwo
            ]
        ]
