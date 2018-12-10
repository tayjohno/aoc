module Day06 exposing (debug, partOne, partTwo)

import Array exposing (Array)
import Day06.Input exposing (input)
import Matrix exposing (..)


type ClaimStatus
    = Claimed Region
    | Contested
    | Unclaimed


type alias Region =
    Int


debug : Maybe String
debug =
    emptyBestFitMatrix input
        |> addStartingPoints input
        |> Matrix.toString claimStatusChar
        |> Just


claimStatusChar : ClaimStatus -> Char
claimStatusChar claimStatus =
    case claimStatus of
        Claimed region ->
            intToChar region

        Contested ->
            '*'

        Unclaimed ->
            ' '


intToChar : Int -> Char
intToChar int =
    let
        characters =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                |> String.toList
                |> Array.fromList
    in
    Maybe.withDefault '?' (Array.get int characters)


partOne : Maybe String
partOne =
    Nothing


emptyBestFitMatrix : List Coordinate -> Matrix ClaimStatus
emptyBestFitMatrix input =
    let
        maxWidth =
            input
                |> List.map Tuple.first
                |> List.maximum
                |> Maybe.withDefault 0

        maxHeight =
            input
                |> List.map Tuple.second
                |> List.maximum
                |> Maybe.withDefault 0
    in
    Matrix.empty ( maxWidth + 1, maxHeight + 1 ) Unclaimed


addStartingPoints : List Coordinate -> Matrix ClaimStatus -> Matrix ClaimStatus
addStartingPoints =
    addStartingPointsHelper 0


addStartingPointsHelper : Int -> List Coordinate -> Matrix ClaimStatus -> Matrix ClaimStatus
addStartingPointsHelper index coordinateList matrix =
    case coordinateList of
        [] ->
            matrix

        head :: tail ->
            addStartingPointsHelper (index + 1) tail (Matrix.set head (Claimed index) matrix)


updateMap : List Coordinate -> Matrix ClaimStatus -> Matrix ClaimStatus
updateMap list matrix =
    updateMapHelper list matrix matrix


updateMapHelper : List Coordinate -> List Coordinate -> Matrix ClaimStatus -> Matrix ClaimStatus -> Matrix ClaimStatus
updateMapHelper checked unchecked newMatrix oldMatrix =
    case ( checked, unchecked ) of
        ( [], [] ) ->
            -- Finished
            newMatrix

        ( _, [] ) ->
            -- Another Pass
            updateMapHelper [] checked newMatrix newMatrix

        ( _, head :: tail ) ->
            case Maybe.withDefault Unclaimed (Matrix.get head oldMatrix) of
                Unclaimed ->
                    if Debug.todo "Can Claim" then
                        Debug.todo "Claim"
                            Debug.todo
                            "Remove from Queue"

                    else
                        Debug.todo "Move to back of queue"

                _ ->
                    updateMapHelper checked tail newMatrix oldMatrix


neighbors : Coordinate -> List Coordinate
neighbors ( x, y ) =
    [ ( x - 1, y ), ( x + 1, y ), ( x, y - 1 ), ( x, y + 1 ) ]


partTwo : Maybe String
partTwo =
    Nothing
