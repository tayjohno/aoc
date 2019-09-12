module Day05 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Char exposing (Char)
import Day05.Input exposing (input)


partOne : () -> Answer String
partOne =
    \_ ->
        input
            |> String.toList
            |> partOneHelper
            |> List.length
            |> String.fromInt
            |> Solved


partTwo : () -> Answer String
partTwo =
    \_ ->
        let
            refinedInput : String
            refinedInput =
                input
                    |> String.toList
                    |> partOneHelper
                    |> String.fromList
        in
        letters
            |> List.map
                (\letter ->
                    refinedInput
                        |> String.replace (String.fromChar letter) ""
                        |> String.replace (String.fromChar (Char.toUpper letter)) ""
                        |> String.toList
                        |> partOneHelper
                        |> List.length
                )
            |> List.sort
            |> List.head
            |> (\i ->
                    case i of
                        Nothing ->
                            Unsolved

                        Just int ->
                            Solved (String.fromInt int)
               )


partOneHelper : List Char -> List Char
partOneHelper originalList =
    let
        startLength =
            List.length originalList

        newList =
            duplicateRemover [] originalList
    in
    if List.length newList < List.length originalList then
        partOneHelper newList

    else
        newList


duplicateRemover : List Char -> List Char -> List Char
duplicateRemover outputList inputList =
    case inputList of
        c1 :: c2 :: rest ->
            if c1 /= c2 && Char.toLower c1 == Char.toLower c2 then
                -- remove the duplicate and take one step BACKWARDS if possible
                case outputList of
                    lastOutput :: others ->
                        duplicateRemover others (lastOutput :: rest)

                    _ ->
                        duplicateRemover outputList rest

            else
                duplicateRemover (c1 :: outputList) (c2 :: rest)

        _ ->
            List.append (List.reverse outputList) inputList


letters =
    String.toList "abcdefghijklmnopqrstuvwxyz"
