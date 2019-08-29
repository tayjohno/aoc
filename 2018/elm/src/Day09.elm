module Day09 exposing (partOne, partTwo)

import Day09.MarbleCircle exposing (newGame, playTo, winningScore)


partOne : () -> Maybe String
partOne =
    \_ ->
        Just (newGame 439 |> playTo 71307 |> winningScore |> String.fromInt)


partTwo : () -> Maybe String
partTwo =
    \_ ->
        Nothing
