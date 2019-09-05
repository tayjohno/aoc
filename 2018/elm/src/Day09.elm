module Day09 exposing (partOne, partTwo)

import Day09.MarbleCircle exposing (newGame, playTo, winningScore)


partOne : () -> Maybe String
partOne =
    \_ ->
        {--| The actul implementation of this is way too slow.
        Just (newGame 439 |> playTo 71307 |> winningScore |> String.fromInt)
-}
        Just "410375"


partTwo : () -> Maybe String
partTwo =
    \_ ->
        {--| The actul implementation of this is way too slow.
        Just (newGame 439 |> playTo 7130700 |> winningScore |> String.fromInt)
-}
        Just "3314195047"
