module DynamicMatrix exposing (Coordinate, Matrix, double, doubleMatrixFrom, empty, get, insertBetween, prettyPrint, printLines, set, transformElement)

import Array exposing (Array)


type alias Matrix a =
    { data : Array a, size : Int, default : a }


type alias Coordinate =
    { x : Int, y : Int }



-- Default "empty" starting point is an 4x4 matrix. This felt like a good size from a


empty : a -> Matrix a
empty defaultVal =
    { data = Array.fromList (List.repeat 16 defaultVal)
    , size = 4
    , default = defaultVal
    }


set : Coordinate -> a -> Matrix a -> Matrix a
set coordinate val matrix =
    if coordinate.x < 0 || coordinate.y < 0 then
        -- Negative out of bounds (do nothing)
        matrix

    else if coordinate.x < matrix.size && coordinate.y < matrix.size then
        -- Within bounds (insert)
        { data = Array.set (coordinate.x + matrix.size * coordinate.y) val matrix.data
        , size = matrix.size
        , default = matrix.default
        }

    else
        -- Positive out of bounds (expand the matrix)
        set coordinate val (double matrix)


get : Coordinate -> Matrix a -> Maybe a
get coordinate matrix =
    if coordinate.x < 0 || coordinate.y < 0 then
        Nothing

    else if coordinate.x < matrix.size && coordinate.y < matrix.size then
        Just
            (matrix.data
                |> Array.get (coordinate.x + matrix.size * coordinate.y)
                |> Maybe.withDefault matrix.default
            )

    else
        Just matrix.default


transformElement : Coordinate -> (a -> a) -> Matrix a -> Matrix a
transformElement coordinate transformation matrix =
    let
        value =
            Maybe.withDefault matrix.default (get coordinate matrix)
    in
    set coordinate (transformation value) matrix



-- PRIVATE METHODS


double : Matrix a -> Matrix a
double matrix =
    doubleMatrixFrom 0 matrix


doubleMatrixFrom : Int -> Matrix a -> Matrix a
doubleMatrixFrom index matrix =
    let
        dividingPoint =
            matrix.size + matrix.size * 2 * index
    in
    if dividingPoint >= Array.length matrix.data then
        { data =
            -- Append the bottom half of the empty matrix
            List.repeat (matrix.size * matrix.size * 2 + matrix.size) matrix.default
                |> Array.fromList
                |> Array.append matrix.data
        , size = matrix.size * 2
        , default = matrix.default
        }

    else
        doubleMatrixFrom (index + 1)
            { data =
                List.repeat matrix.size matrix.default
                    |> Array.fromList
                    |> insertAt dividingPoint matrix.data
            , size = matrix.size
            , default = matrix.default
            }


insertAt : Int -> Array a -> Array a -> Array a
insertAt index outer inner =
    let
        firstHalf =
            Array.slice 0 index outer

        secondHalf =
            Array.slice index (Array.length outer) outer
    in
    insertBetween firstHalf secondHalf inner


insertBetween : Array a -> Array a -> Array a -> Array a
insertBetween firstHalf secondHalf value =
    secondHalf
        |> Array.append value
        |> Array.append firstHalf


prettyPrint : Matrix a -> Maybe a
prettyPrint matrix =
    if Array.length matrix.data == 0 then
        Nothing

    else
        printLines 0 matrix


printLines : Int -> Matrix a -> Maybe a
printLines index matrix =
    let
        nextRow =
            Array.slice (index * matrix.size) ((index + 1) * matrix.size) matrix.data
    in
    if Array.length nextRow > 0 && Array.length (Debug.log "" nextRow) > 0 then
        printLines (index + 1) matrix

    else
        Nothing
