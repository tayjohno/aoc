module Day07 exposing (alphabet, nextCharAvailable, partOne, partOneHelper, partTwo)

import Answer exposing (Answer(..))
import Day07.DataTypes exposing (Prerequisite)
import Day07.Input exposing (input)


partOne : () -> Answer String
partOne =
    \_ ->
        Solved (partOneHelper alphabet input)


partTwo : () -> Answer String
partTwo =
    \_ ->
        partTwoHelper 0 alphabet input []
            |> String.fromInt
            |> Solved


type alias Worker =
    { duration : Int, letter : Char }


alphabet =
    String.toList "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


partOneHelper : List Char -> List Prerequisite -> String
partOneHelper chars prerequisites =
    let
        char =
            nextCharAvailable chars prerequisites
    in
    case char of
        Nothing ->
            ""

        Just character ->
            String.fromChar character
                ++ partOneHelper (remove character chars) (removeComplete character prerequisites)


partTwoHelper : Int -> List Char -> List Prerequisite -> List Worker -> Int
partTwoHelper t chars prerequisites workers =
    let
        advancedWorkers =
            tickWorkers workers

        lettersCompleted =
            advancedWorkers
                |> List.filter (\{ duration, letter } -> duration == 0)
                |> List.map .letter

        remainingPrerequisites =
            List.foldl removeComplete prerequisites lettersCompleted

        workingWorkers =
            advancedWorkers
                |> List.filter (\{ duration, letter } -> duration > 0)

        workersAvailable =
            5 - List.length workingWorkers

        newWorkers =
            spawnWorkers chars remainingPrerequisites workersAvailable

        charsRemaining =
            List.foldl (\{ duration, letter } charList -> remove letter charList) chars newWorkers

        allWorkers =
            List.append workingWorkers newWorkers
    in
    if chars == [] && allWorkers == [] then
        t

    else
        partTwoHelper (t + 1) charsRemaining remainingPrerequisites allWorkers


removeComplete : Char -> List Prerequisite -> List Prerequisite
removeComplete character =
    List.filter (\( prerequisite, _ ) -> prerequisite /= character)


spawnWorkers : List Char -> List Prerequisite -> Int -> List Worker
spawnWorkers chars prerequisites workersAvailable =
    if workersAvailable == 0 then
        []

    else
        case nextCharAvailable chars prerequisites of
            Nothing ->
                []

            Just char ->
                Worker (durationFor char) char :: spawnWorkers (remove char chars) prerequisites (workersAvailable - 1)


remove : a -> List a -> List a
remove a =
    List.filter ((/=) a)


durationFor : Char -> Int
durationFor char =
    Char.toCode char - Char.toCode 'A' + 61


tickWorkers : List Worker -> List Worker
tickWorkers workers =
    List.map (\worker -> { duration = worker.duration - 1, letter = worker.letter }) workers


charsAvailable : List Char -> List Prerequisite -> List Char
charsAvailable chars prerequisites =
    chars
        |> List.filter
            (\a ->
                not (List.any (\( _, b ) -> a == b) prerequisites)
            )


nextCharAvailable : List Char -> List Prerequisite -> Maybe Char
nextCharAvailable chars prerequisites =
    charsAvailable chars prerequisites
        |> List.head
