module Day09.MarbleCircle exposing (MarbleCircle, findAtIndex, insertAtIndex, newGame, playTo, removeAtIndex, rotate, takeTurn, winningScore)

import Dict exposing (Dict)


type alias MarbleCircle =
    { currentValue : Int, circle : List Int, currentPosition : Int, size : Int, playersOrder : List Int, scores : Dict Int Int }


newGame : Int -> MarbleCircle
newGame players =
    let
        playerNumbers =
            List.range 1 players

        playerScores =
            playerNumbers
                |> List.map (\n -> ( n, 0 ))
                |> Dict.fromList
    in
    MarbleCircle 1 [ 0 ] 1 1 playerNumbers playerScores


winningScore : MarbleCircle -> Int
winningScore marbleCircle =
    marbleCircle.scores
        |> Dict.values
        |> List.maximum
        |> Maybe.withDefault 0


playTo : Int -> MarbleCircle -> MarbleCircle
playTo turns marbleCircle =
    if turns >= marbleCircle.currentValue then
        playTo turns (takeTurn marbleCircle)

    else
        marbleCircle


takeTurn : MarbleCircle -> MarbleCircle
takeTurn { currentValue, circle, currentPosition, size, playersOrder, scores } =
    if modBy 23 currentValue == 0 then
        let
            newSize =
                size - 1

            newPlayers =
                rotate playersOrder

            newValue =
                currentValue + 1

            removeAt =
                modBy size (currentPosition - 9)

            newPosition =
                modBy newSize (removeAt + 1) + 1

            newCircle =
                removeAtIndex removeAt circle

            pointsEarned =
                Maybe.withDefault 0 (findAtIndex removeAt circle) + currentValue

            newScore =
                Dict.update
                    (Maybe.withDefault 0 (List.head playersOrder))
                    (\a -> Just (Maybe.withDefault 0 a + pointsEarned))
                    scores
        in
        MarbleCircle newValue newCircle newPosition newSize newPlayers newScore

    else
        let
            newSize =
                size + 1

            newPlayers =
                rotate playersOrder

            newValue =
                currentValue + 1

            newCircle =
                insertAtIndex currentPosition currentValue circle

            newPosition =
                modBy newSize (currentPosition + 1) + 1
        in
        MarbleCircle newValue newCircle newPosition newSize newPlayers scores


insertAtIndex : Int -> a -> List a -> List a
insertAtIndex index value list =
    List.append (List.take index list) (value :: List.drop index list)


findAtIndex : Int -> List a -> Maybe a
findAtIndex index list =
    list
        |> List.drop index
        |> List.head


removeAtIndex : Int -> List a -> List a
removeAtIndex index list =
    List.append (List.take index list) (List.drop (index + 1) list)


rotate : List a -> List a
rotate aList =
    case aList of
        [] ->
            []

        a :: list ->
            List.append list [ a ]
