module Day14 exposing (input)

import Array exposing (Array)


input =
    633601


partOne : Array (Maybe Int)
partOne =
    Array.initialize input (always Nothing)


partTwo : () -> Maybe String
partTwo =
    Nothing
