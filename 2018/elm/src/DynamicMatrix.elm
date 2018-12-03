module DynamicMatrix exposing (Matrix)

import Array exposing (Array)


type alias Matrix comparable =
    ( Array comparable, Int )


prettyPrint : Matrix comparable -> Maybe a
prettyPrint ( array, size ) =
    if Array.length array == 0 then
        Nothing

    else
        printLines 0 ( array, size )


printLines : Int -> Matrix comparable -> Maybe a
printLines index matrix =
    let
        nextRow =
            Array.slice
    in
    if Array.length (Debug.log "" nextRow) > 0 then
        printLines (index + 1) matrix

    else
        Nothing


empty : Matrix comparable
empty =
    ( Array.empty, 0 )
