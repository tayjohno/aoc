module Array2DMatrix exposing (Matrix, Size, allCoordinates, allCoordinatesHelper, customPrint, eightNeighbors, empty, findAll, fromRows, get, locations, map, prettyPrint, set, toRows, toString, transformElement)

{-
   This was originally created as an alternative to Matrix, but it turns
   out that it wasn't necessary. It's possible that it would be faster,
   but for now I'm just deprecating it and switching everything back to
   Matrix.
-}

import Array exposing (Array)
import Coordinate exposing (Coordinate, down, left, right, up)


type alias Matrix a =
    { data : Array (Array a), size : Size }


{-| (width, height)
-}
type alias Size =
    ( Int, Int )


mWidth =
    .size >> width


mHeight =
    .size >> height


width : Size -> Int
width =
    Tuple.first


height : Size -> Int
height =
    Tuple.second


empty : Size -> a -> Matrix a
empty size defaultVal =
    let
        row =
            Array.fromList (List.repeat (size |> Tuple.first) defaultVal)
    in
    { data = Array.fromList (List.repeat (size |> Tuple.second) row)
    , size = size
    }


set : Coordinate -> a -> Matrix a -> Matrix a
set ( x, y ) val matrix =
    let
        newRow =
            Array.get y matrix.data
                |> Maybe.andThen (\a -> Array.set x val a |> Just)
    in
    if isWithin matrix.size ( x, y ) then
        case newRow of
            Just rowData ->
                -- Within bounds (insert)
                { data = Array.set y rowData matrix.data
                , size = matrix.size
                }

            Nothing ->
                -- Within bounds but not returned.. shouldn't be possible
                matrix

    else
        -- Out of bounds (do nothing)
        matrix


get : Coordinate -> Matrix a -> Maybe a
get ( x, y ) matrix =
    if isWithin matrix.size ( x, y ) then
        matrix.data
            |> Array.get y
            |> Maybe.andThen (Array.get x)

    else
        Nothing


{-| Return all the locations of a given item in the matrix
-}
locations : (a -> Bool) -> Matrix a -> List Coordinate
locations aMatcher aMatrix =
    aMatrix.data
        |> Array.indexedMap
            (\y row ->
                row
                    |> Array.indexedMap
                        (\x elem ->
                            if aMatcher elem then
                                Just ( x, y )

                            else
                                Nothing
                        )
            )
        |> Array.foldl Array.append Array.empty
        |> Array.foldl
            (\maybeC acc ->
                case maybeC of
                    Nothing ->
                        acc

                    Just a ->
                        a :: acc
            )
            []


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
toRows =
    .data
        >> Array.map Array.toList
        >> Array.toList


fromRows : List (List a) -> a -> Matrix a
fromRows rows default =
    let
        size =
            ( rows |> List.map List.length |> List.maximum |> Maybe.withDefault 0
            , rows |> List.length
            )

        data =
            rows
                |> Array.fromList
                |> Array.map Array.fromList
    in
    { data = data
    , size = size
    }


allCoordinates : Matrix a -> List Coordinate
allCoordinates matrix =
    allCoordinatesHelper 0 matrix.size


allCoordinatesHelper : Int -> Size -> List Coordinate
allCoordinatesHelper index size =
    if index >= height size then
        []

    else
        List.append (List.map (\a -> ( a, index )) (List.range 0 ((size |> width) - 1))) (allCoordinatesHelper (index + 1) size)


findAll : (a -> Bool) -> Matrix a -> List ( a, Coordinate )
findAll function matrix =
    locations function matrix
        |> List.map (\coordinate -> ( get coordinate matrix, coordinate ))
        |> List.map
            (\( maybeA, coordinate ) ->
                case maybeA of
                    Nothing ->
                        Debug.todo "Coordinate out of range"

                    Just a ->
                        ( a, coordinate )
            )


map : (Coordinate -> Matrix a -> a) -> Matrix a -> Matrix a
map function matrix =
    matrix
        |> allCoordinates
        |> List.foldl
            (\coordinate ->
                set coordinate (function coordinate matrix)
            )
            matrix


eightNeighbors : Matrix a -> Coordinate -> List a
eightNeighbors matrix coord =
    coord
        |> Coordinate.eightNeighbors
        |> List.filterMap (\c -> get c matrix)


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
isWithin size ( x, y ) =
    x >= 0 && y >= 0 && x < (size |> width) && y < (size |> height)


prettyPrint : Matrix a -> Matrix a
prettyPrint matrix =
    matrix
        |> toRows
        |> List.reverse
        |> List.map (\a -> Debug.log "" a)
        |> always matrix


{-| A compact way to print out any matrix.

Must provide a way to map any instance of `a` to a single character.

-}
customPrint : (a -> Char) -> Matrix a -> Matrix a
customPrint function matrix =
    matrix
        |> customPrintHelper function 0
        |> always matrix



-- PRIVATE METHODS


customPrintHelper : (a -> Char) -> Int -> Matrix a -> Matrix a
customPrintHelper function row matrix =
    if row >= mHeight matrix then
        matrix

    else
        let
            _ =
                matrix.data
                    |> Array.get row
                    |> Maybe.andThen (Array.toList >> Just)
                    |> Maybe.andThen (List.map function >> Just)
                    |> Maybe.andThen (String.fromList >> Just)
                    |> Maybe.andThen (Debug.log "" >> Just)
        in
        customPrintHelper function (row + 1) matrix


{-| Convert an array index to a coordinate.
-}
indexToCoordinate : Int -> Matrix a -> Coordinate
indexToCoordinate int { size } =
    let
        x =
            remainderBy (width size) int

        y =
            int // width size
    in
    ( x, y )
