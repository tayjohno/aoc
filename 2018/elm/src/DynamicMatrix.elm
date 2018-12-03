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
printLines index ( array, size ) =
    let
        nextRow =
            Array.slice (index * size) (index * (size + 1)) array
    in
    if Array.length (Debug.log "" nextRow) > 0 then
        printLines (index + 1) ( array, size )

    else
        Nothing


empty : Matrix comparable
empty =
    ( Array.empty, 0 )
