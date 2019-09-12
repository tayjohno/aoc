module Day06 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Array exposing (Array)
import Day06.Input exposing (input)
import List.Unique
import Matrix exposing (..)


type ClaimStatus
    = Claimed Region
    | Contested
    | Unclaimed


type alias Region =
    Int


partOne : () -> Answer String
partOne =
    \_ ->
        let
            fullMap =
                emptyBestFitMatrix input
                    |> addStartingPoints input
                    |> (\matrix -> updateMap (allCoordinates matrix) matrix)

            regions =
                fullMap
                    |> surroundedRegions
        in
        regions
            |> List.map (\region -> ( region, regionSize fullMap region ))
            |> List.sortBy Tuple.second
            |> List.reverse
            |> List.head
            |> (\a ->
                    case a of
                        Just tuple ->
                            tuple
                                |> Tuple.second
                                |> String.fromInt
                                |> Solved

                        Nothing ->
                            Unsolved
               )


partTwo : () -> Answer String
partTwo =
    \_ ->
        let
            startingPointsList =
                input

            allCoordsList =
                Matrix.allCoordinates (emptyBestFitMatrix input)
        in
        allCoordsList
            |> List.map (\c1 -> List.foldl (\c2 sum -> distanceBetween c1 c2 + sum) 0 startingPointsList)
            |> List.filter ((>) 10000)
            |> List.length
            |> String.fromInt
            |> Solved


debug : Maybe String
debug =
    emptyBestFitMatrix input
        |> addStartingPoints input
        |> (\matrix -> updateMap (allCoordinates matrix) matrix)
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


uniqueRegions : Matrix ClaimStatus -> List Region
uniqueRegions matrix =
    matrix.data
        |> Array.toList
        |> List.Unique.fromList
        |> List.Unique.toList
        |> List.filterMap
            (\claim ->
                case claim of
                    Claimed a ->
                        Just a

                    _ ->
                        Nothing
            )


surroundedRegions : Matrix ClaimStatus -> List Region
surroundedRegions matrix =
    let
        borderRegionsList =
            borderRegions matrix
    in
    uniqueRegions matrix
        |> List.filter (\region -> not (List.member region borderRegionsList))


borderCoordinates : Matrix ClaimStatus -> List Coordinate
borderCoordinates matrix =
    let
        ( width, height ) =
            matrix.size
    in
    Matrix.allCoordinates matrix
        |> List.filter (\( x, y ) -> x == 0 || y == 0 || x == width - 1 || y == height - 1)


borderRegions : Matrix ClaimStatus -> List Region
borderRegions matrix =
    borderCoordinates matrix
        |> List.filterMap
            (\coord ->
                case Matrix.get coord matrix of
                    Just (Claimed region) ->
                        Just region

                    _ ->
                        Nothing
            )
        |> List.Unique.fromList
        |> List.Unique.toList


regionSize : Matrix ClaimStatus -> Region -> Int
regionSize matrix region =
    matrix.data
        |> Array.filter (\a -> a == Claimed region)
        |> Array.length


intToChar : Int -> Char
intToChar int =
    let
        characters =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                |> String.toList
                |> Array.fromList
    in
    Maybe.withDefault '?' (Array.get int characters)


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
    updateMapHelper [] list matrix matrix


updateMapHelper : List Coordinate -> List Coordinate -> Matrix ClaimStatus -> Matrix ClaimStatus -> Matrix ClaimStatus
updateMapHelper stillUnclaimed unchecked newMatrix oldMatrix =
    case ( stillUnclaimed, unchecked ) of
        ( [], [] ) ->
            -- Finished
            newMatrix

        ( _, [] ) ->
            -- Another Pass
            let
                stillUnclaimedLength =
                    List.length stillUnclaimed
            in
            updateMapHelper [] stillUnclaimed newMatrix newMatrix

        ( _, head :: tail ) ->
            case Maybe.withDefault Unclaimed (Matrix.get head oldMatrix) of
                Unclaimed ->
                    case checkNeighbors head oldMatrix of
                        Unclaimed ->
                            updateMapHelper (head :: stillUnclaimed) tail newMatrix oldMatrix

                        status ->
                            updateMapHelper stillUnclaimed tail (Matrix.set head status newMatrix) oldMatrix

                _ ->
                    -- was already claimed, remove from set.
                    updateMapHelper stillUnclaimed tail newMatrix oldMatrix


checkNeighbors : Coordinate -> Matrix ClaimStatus -> ClaimStatus
checkNeighbors coordinate matrix =
    let
        neighborClaims =
            neighbors coordinate
                |> List.filterMap (\coord -> Matrix.get coord matrix)
                |> List.filterMap
                    -- Remove unclaimed
                    (\status ->
                        if status == Unclaimed then
                            Nothing

                        else
                            Just status
                    )
                |> List.Unique.fromList
                |> List.Unique.toList
    in
    case neighborClaims of
        [] ->
            Unclaimed

        [ Claimed a ] ->
            Claimed a

        _ ->
            Contested


neighbors : Coordinate -> List Coordinate
neighbors ( x, y ) =
    [ ( x - 1, y ), ( x + 1, y ), ( x, y - 1 ), ( x, y + 1 ) ]


distanceBetween : Coordinate -> Coordinate -> Int
distanceBetween ( x1, y1 ) ( x2, y2 ) =
    abs (x1 - x2) + abs (y1 - y2)
