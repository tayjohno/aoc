module Day09 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Day09.MarbleCircle exposing (newGame, playTo, winningScore)


partOne : () -> Answer String
partOne =
    \_ ->
        {--| The actul implementation of this is way too slow.
        Solved (newGame 439 |> playTo 71307 |> winningScore |> String.fromInt)
-}
        Faked "410375"


partTwo : () -> Answer String
partTwo =
    \_ ->
        {--| The actul implementation of this is way too slow.
        Solved (newGame 439 |> playTo 7130700 |> winningScore |> String.fromInt)
-}
        Faked "3314195047"
