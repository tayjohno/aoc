module Day09 exposing (partOne, partTwo)

import Day09.MarbleCircle exposing (newGame, playTo, winningScore)


partOne =
    Just (newGame 439 |> playTo 71307 |> winningScore)


partTwo =
    Nothing
