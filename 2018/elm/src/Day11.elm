module Day11 exposing (calculateScore, empty, input, mapCoordinates, mapCoordinatesHelper, partOne, partTwo, scoreTotaller)

import Matrix exposing (Coordinate, Matrix)


input : Int
input =
    1308


partOne : () -> Maybe String
partOne _ =
    let
        matrix =
            mapCoordinates (calculateScore input) empty
    in
    partOneHelper ( 0, 0 ) matrix Nothing
        |> Maybe.andThen (toString >> Just)


partTwo : () -> Maybe String
partTwo _ =
    Nothing


toString : Coordinate -> String
toString ( x, y ) =
    String.fromInt x ++ "," ++ String.fromInt y


partOneHelper : Coordinate -> Matrix Int -> Maybe ( Int, Coordinate ) -> Maybe Coordinate
partOneHelper ( x, y ) matrix best =
    let
        nextScore =
            partOneScore ( x, y ) matrix

        newBest =
            case nextScore of
                Nothing ->
                    best

                Just newScore ->
                    case best of
                        Nothing ->
                            Just ( newScore, ( x, y ) )

                        Just ( oldScore, _ ) ->
                            if oldScore > newScore then
                                best

                            else
                                Just ( newScore, ( x, y ) )
    in
    if y > 298 then
        case best of
            Just ( int, coord ) ->
                Just coord

            Nothing ->
                Nothing

    else if x > 298 then
        partOneHelper ( 0, y + 1 ) matrix best

    else
        partOneHelper ( x + 1, y ) matrix newBest


partOneScore : Coordinate -> Matrix Int -> Maybe Int
partOneScore ( x, y ) matrix =
    if x < 298 && y < 298 then
        Maybe.withDefault 0 (Matrix.get ( x, y ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 1, y ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 2, y ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x, y + 1 ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 1, y + 1 ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 2, y + 1 ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x, y + 2 ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 1, y + 2 ) matrix)
            + Maybe.withDefault 0 (Matrix.get ( x + 2, y + 2 ) matrix)
            |> Just

    else
        Nothing


mapCoordinates : (Coordinate -> a) -> Matrix a -> Matrix a
mapCoordinates function matrix =
    mapCoordinatesHelper ( 0, 0 ) function matrix


mapCoordinatesHelper : Coordinate -> (Coordinate -> a) -> Matrix a -> Matrix a
mapCoordinatesHelper ( x, y ) method matrix =
    if y > Tuple.second matrix.size then
        matrix

    else if x > Tuple.first matrix.size then
        mapCoordinatesHelper ( 0, y + 1 ) method matrix

    else
        mapCoordinatesHelper
            ( x + 1, y )
            method
            (Matrix.set ( x, y ) (method ( x, y )) matrix)


scoreTotaller : Int -> List Coordinate -> Matrix Int -> Matrix Int
scoreTotaller offset coordinateList matrix =
    let
        length =
            List.length coordinateList

        log =
            if (length |> modBy 1000) == 0 then
                Debug.log "length" length

            else
                length
    in
    case coordinateList of
        [] ->
            matrix

        coord :: list ->
            scoreTotaller
                offset
                list
                (Matrix.set
                    coord
                    (calculateScore offset coord)
                    matrix
                )


calculateScore : Int -> Coordinate -> Int
calculateScore offset ( x, y ) =
    modBy
        1000
        ((((x + 10) * y) + offset) * (x + 10))
        // 100
        - 5


empty : Matrix Int
empty =
    Matrix.empty ( 300, 300 ) 0
