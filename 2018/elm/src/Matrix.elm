module Matrix exposing (Coordinate, Matrix, Size, allCoordinates, allCoordinatesHelper, empty, get, set, toRows, toString, transformElement)

import Array exposing (Array)


type alias Matrix a =
    { data : Array a, size : Size }


type alias Size =
    ( Int, Int )


type alias Coordinate =
    ( Int, Int )


empty : Size -> a -> Matrix a
empty size defaultVal =
    { data = Array.fromList (List.repeat ((\( w, h ) -> w * h) size) defaultVal)
    , size = size
    }


set : Coordinate -> a -> Matrix a -> Matrix a
set ( x, y ) val matrix =
    let
        ( width, height ) =
            matrix.size
    in
    if isWithin ( width, height ) ( x, y ) then
        -- Within bounds (insert)
        { data = Array.set (x + width * y) val matrix.data
        , size = matrix.size
        }

    else
        -- Out of bounds (do nothing)
        matrix


get : Coordinate -> Matrix a -> Maybe a
get ( x, y ) matrix =
    let
        ( width, height ) =
            matrix.size
    in
    if isWithin ( width, height ) ( x, y ) then
        matrix.data
            |> Array.get (x + width * y)

    else
        Nothing


transformElement : Coordinate -> (a -> a) -> Matrix a -> Matrix a
transformElement coordinate transformation matrix =
    let
        value =
            get coordinate matrix
    in
    case value of
        Nothing ->
            matrix

        Just a ->
            set coordinate (transformation a) matrix


toRows : Matrix a -> List (List a)
toRows matrix =
    let
        ( width, height ) =
            matrix.size
    in
    if height == 0 then
        []

    else
        List.take width (Array.toList matrix.data)
            :: toRows
                { data = Array.fromList (List.drop width (Array.toList matrix.data))
                , size = ( width, height - 1 )
                }


allCoordinates : Matrix a -> List Coordinate
allCoordinates matrix =
    allCoordinatesHelper 0 matrix.size


allCoordinatesHelper : Int -> Size -> List Coordinate
allCoordinatesHelper index ( width, height ) =
    if index >= height then
        []

    else
        List.append (List.map (\a -> ( a, index )) (List.range 0 (width - 1))) (allCoordinatesHelper (index + 1) ( width, height ))


toString : (a -> Char) -> Matrix a -> String
toString coersion matrix =
    toStringHelper coersion (toRows matrix)



-- PRIVATE METHODS


toStringHelper : (a -> Char) -> List (List a) -> String
toStringHelper coersion list =
    case list of
        [] ->
            ""

        head :: tail ->
            String.fromList (List.map coersion head) ++ "\n" ++ toStringHelper coersion tail


isWithin : Size -> Coordinate -> Bool
isWithin ( width, height ) ( x, y ) =
    x >= 0 && y >= 0 && x < width && y < height


prettyPrint : Matrix a -> Maybe a
prettyPrint matrix =
    if Array.length matrix.data == 0 then
        Nothing

    else
        printLines 0 matrix


printLines : Int -> Matrix a -> Maybe a
printLines index matrix =
    let
        ( width, height ) =
            matrix.size

        nextRow =
            Array.slice (index * width) ((index + 1) * width) matrix.data
    in
    if height > 0 then
        printLines (index + 1) matrix

    else
        Nothing
