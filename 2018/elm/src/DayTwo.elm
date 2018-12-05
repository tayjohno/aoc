module DayTwo exposing (partOne, partTwo)

import DayTwo.Input exposing (input)
import Dict exposing (Dict)


partOne : String
partOne =
    let
        checksumParts =
            input
                |> List.map checksumTuple
                |> List.unzip

        twos =
            sum (Tuple.first checksumParts)

        threes =
            sum (Tuple.second checksumParts)
    in
    (twos * threes)
        |> String.fromInt


checksumTuple : String -> ( Int, Int )
checksumTuple string =
    ( if hasNOfAKind 2 string then
        1

      else
        0
    , if hasNOfAKind 3 string then
        1

      else
        0
    )


sum : List Int -> Int
sum =
    List.foldl (\a b -> a + b) 0


hasNOfAKind : Int -> String -> Bool
hasNOfAKind n string =
    letterCounts string
        |> Dict.values
        |> List.member n


letterCounts : String -> Dict Char Int
letterCounts string =
    letterCountsIterator
        (String.toList string)
        Dict.empty


letterCountsIterator : List Char -> Dict Char Int -> Dict Char Int
letterCountsIterator chars dictionary =
    case chars of
        [] ->
            dictionary

        char :: remainder ->
            letterCountsIterator remainder
                (Dict.insert
                    char
                    (Maybe.withDefault 0 (Dict.get char dictionary) + 1)
                    dictionary
                )


partTwo : String
partTwo =
    idMatchFinder input


idMatchFinder : List String -> String
idMatchFinder ids =
    case ids of
        [] ->
            -- No match found
            ""

        next :: rest ->
            case anyWithinOne next rest of
                Just string ->
                    string

                Nothing ->
                    idMatchFinder rest


anyWithinOne : String -> List String -> Maybe String
anyWithinOne idPattern idList =
    idList
        |> List.map (withinOne idPattern)
        |> findSomething


withinOne : String -> String -> Maybe String
withinOne stringA stringB =
    let
        stringMatch =
            matchingSubstring stringA stringB
    in
    if (String.length stringA - String.length stringMatch) <= 1 then
        Just stringMatch

    else
        Nothing



-- Search through an array for a value that is Just something


findSomething : List (Maybe a) -> Maybe a
findSomething aList =
    aList
        |> List.foldl
            (\a b ->
                if a == Nothing then
                    b

                else
                    a
            )
            Nothing


matchingSubstring : String -> String -> String
matchingSubstring stringA stringB =
    if String.length stringA == 0 then
        ""

    else if head stringA == head stringB then
        String.cons (head stringA) (matchingSubstring (tail stringA) (tail stringB))

    else
        matchingSubstring (tail stringA) (tail stringB)


head : String -> Char
head string =
    string
        |> String.uncons
        |> Maybe.withDefault ( ' ', "" )
        |> Tuple.first


tail : String -> String
tail string =
    string
        |> String.uncons
        |> Maybe.withDefault ( ' ', "" )
        |> Tuple.second
