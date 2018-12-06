module Day03 exposing (addRectangles, partOne, partTwo)

import Array
import Day03.Input exposing (Dimensions, Rectangle, input)
import DynamicMatrix exposing (Coordinate, Matrix, get, set, transformElement)


partOne : Maybe String
partOne =
    matrixSolution.data
        |> Array.toList
        |> countWhere 0 (\a -> a > 1)
        |> String.fromInt
        |> Just


partTwo : Maybe String
partTwo =
    findUniqueRectangle input matrixSolution
        |> String.fromInt
        |> Just


findUniqueRectangle : List Rectangle -> Matrix Int -> Int
findUniqueRectangle rectangleList matrix =
    case rectangleList of
        head :: tail ->
            if rectangleIsUnique head matrix then
                head.id

            else
                findUniqueRectangle tail
                    matrix

        _ ->
            -1


rectangleIsUnique : Rectangle -> Matrix Int -> Bool
rectangleIsUnique rectangle matrix =
    let
        coordinates =
            toCoordinateList rectangle
    in
    coordinates
        |> List.map (\a -> Maybe.withDefault 2 (DynamicMatrix.get a matrix))
        |> List.foldl (*) 1
        |> (==) 1


matrixSolution : Matrix Int
matrixSolution =
    addRectangles input (DynamicMatrix.empty 0)


countWhere : Int -> (a -> Bool) -> List a -> Int
countWhere sum condition array =
    case array of
        [] ->
            sum

        head :: tail ->
            if condition head then
                countWhere (sum + 1) condition tail

            else
                countWhere sum condition tail


addRectangles : List Rectangle -> Matrix Int -> Matrix Int
addRectangles rectangleList matrix =
    case rectangleList of
        head :: tail ->
            addRectangles tail (addRectangle head matrix)

        _ ->
            matrix


addRectangle : Rectangle -> Matrix Int -> Matrix Int
addRectangle rectangle matrix =
    addCoordinates (toCoordinateList rectangle) matrix


addCoordinates : List Coordinate -> Matrix Int -> Matrix Int
addCoordinates coordinateList matrix =
    case coordinateList of
        head :: tail ->
            addCoordinates tail (DynamicMatrix.transformElement head ((+) 1) matrix)

        _ ->
            matrix


toCoordinateList : Rectangle -> List Coordinate
toCoordinateList rectangle =
    toCoordinateListWithIndex 0 rectangle []


toCoordinateListWithIndex : Int -> Rectangle -> List Coordinate -> List Coordinate
toCoordinateListWithIndex index rectangle list =
    let
        nextCoordinate =
            { x = rectangle.coordinate.x + modBy rectangle.dimensions.width (rectangle.coordinate.x + index)
            , y = rectangle.coordinate.y + index // rectangle.dimensions.width
            }
    in
    if index < (rectangle.dimensions.width * rectangle.dimensions.height) then
        toCoordinateListWithIndex
            (index + 1)
            rectangle
            (nextCoordinate :: list)

    else
        list
