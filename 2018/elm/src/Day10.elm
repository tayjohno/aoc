module Day10 exposing (partOne, partOneManual, partTwo)

import Day10.Input exposing (..)
import Matrix exposing (Matrix)



{-
   Right now this must be done manually in `elm repl`
   By calling `Day10.partOne` the matrix will be printed to the screen, where a user can attempt to
   read it manually.
-}


partOneManual : Maybe String
partOneManual =
    input
        |> tickToMinimum
        |> toMatrix
        |> tryToRead


partOne : () -> Maybe String
partOne _ =
    Just "AHFGRKEE"


partTwo : () -> Maybe String
partTwo _ =
    Nothing



-- input |> countTicksToMinimum 0


countTicksToMinimum : Int -> List Pixel -> Int
countTicksToMinimum ticks pixelList =
    let
        area =
            pixelList
                |> pixelSize
                |> (\( a, b ) -> a * b)

        tickedList =
            tickList pixelList

        newArea =
            tickedList
                |> pixelSize
                |> (\( a, b ) -> a * b)
    in
    if newArea < area then
        countTicksToMinimum (ticks + 1) tickedList

    else
        ticks


tickToMinimum : List Pixel -> List Pixel
tickToMinimum pixelList =
    let
        area =
            pixelList
                |> pixelSize
                |> (\( a, b ) -> a * b)

        tickedList =
            tickList pixelList

        newArea =
            tickedList
                |> pixelSize
                |> (\( a, b ) -> a * b)
    in
    if newArea < area then
        tickToMinimum tickedList

    else
        pixelList


tryToRead : Matrix Char -> Maybe String
tryToRead matrix =
    Matrix.toRows matrix
        |> List.reverse
        |> List.map String.fromList
        |> List.map (Debug.log "")
        |> (\a -> Nothing)


toMatrix : List Pixel -> Matrix Char
toMatrix pixelList =
    let
        coordinates =
            pixelList |> List.map (\pixel -> pixel.position)

        minX =
            coordinates |> List.map Tuple.first |> List.minimum |> Maybe.withDefault 0

        minY =
            coordinates |> List.map Tuple.second |> List.minimum |> Maybe.withDefault 0

        normalizedCoordinates =
            coordinates |> List.map (\( x, y ) -> ( x - minX, y - minY ))
    in
    Matrix.empty (pixelSize pixelList) ' '
        |> addPixels normalizedCoordinates


addPixels : List Position -> Matrix Char -> Matrix Char
addPixels positionList matrix =
    case positionList of
        [] ->
            matrix

        position :: list ->
            addPixels list (Matrix.set position '#' matrix)


pixelSize : List Pixel -> Matrix.Size
pixelSize pixelList =
    ( (pixelList
        |> List.map (\pixel -> pixel.position |> Tuple.first)
        |> List.maximum
        |> Maybe.withDefault 0
      )
        - (pixelList
            |> List.map (\pixel -> pixel.position |> Tuple.first)
            |> List.minimum
            |> Maybe.withDefault 0
          )
        + 1
    , (pixelList
        |> List.map (\pixel -> pixel.position |> Tuple.second)
        |> List.maximum
        |> Maybe.withDefault 0
      )
        - (pixelList
            |> List.map (\pixel -> pixel.position |> Tuple.second)
            |> List.minimum
            |> Maybe.withDefault 0
          )
        + 1
    )


tickList : List Pixel -> List Pixel
tickList pixelList =
    case pixelList of
        pixel :: list ->
            tickPixel pixel :: tickList list

        [] ->
            []


tickPixel : Pixel -> Pixel
tickPixel { position, velocity } =
    let
        ( x, y ) =
            position

        ( dx, dy ) =
            velocity
    in
    { position = ( x + dx, y + dy ), velocity = velocity }
