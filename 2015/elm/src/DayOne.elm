module DayOne exposing (partOne, partTwo)

import DayOneInput exposing (input)


partOne : Int
partOne =
    calculateFloor 0 (String.toList input)


partTwo : Int
partTwo =
    timeToBasement 0 (String.toList input)


calculateFloor : Int -> List Char -> Int
calculateFloor currentFloor commands =
    case commands of
        [] ->
            currentFloor

        '(' :: rest ->
            calculateFloor (currentFloor + 1) rest

        ')' :: rest ->
            calculateFloor (currentFloor - 1) rest

        _ :: rest ->
            calculateFloor currentFloor rest



-- Returns how long until the elevator reaches the basement by following the
-- commands. If the elevator never reaches the basement it returns the total
-- number of commands. If a command is not understood as either '(' or ')', it
-- gets added, but does not move the elevator.


timeToBasement : Int -> List Char -> Int
timeToBasement currentFloor commands =
    if currentFloor < 0 then
        0

    else
        1
            + (case commands of
                [] ->
                    0

                '(' :: rest ->
                    timeToBasement (currentFloor + 1) rest

                ')' :: rest ->
                    timeToBasement (currentFloor - 1) rest

                _ :: rest ->
                    timeToBasement currentFloor rest
              )
