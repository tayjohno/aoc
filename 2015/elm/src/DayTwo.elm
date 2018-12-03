module DayTwo exposing (partOne, partTwo)

import DayTwoInput exposing (Dimensions, input)


partOne =
    input
        |> List.map paperNeeded
        |> sum


partTwo =
    input
        |> List.map ribbonNeeded
        |> sum


paperNeeded : Dimensions -> Int
paperNeeded dimensions =
    surfaceArea dimensions
        + smallestFace dimensions


ribbonNeeded : Dimensions -> Int
ribbonNeeded dimensions =
    smallestPerimeter dimensions
        + volume dimensions


smallestFace : Dimensions -> Int
smallestFace dimensions =
    faceSizes dimensions
        |> List.minimum
        |> Maybe.withDefault 0


smallestPerimeter : Dimensions -> Int
smallestPerimeter dimensions =
    if dimensions.length <= dimensions.height && dimensions.width <= dimensions.height then
        dimensions.length * 2 + dimensions.width * 2

    else if dimensions.length <= dimensions.width && dimensions.height <= dimensions.width then
        dimensions.length * 2 + dimensions.height * 2

    else
        dimensions.width * 2 + dimensions.height * 2


surfaceArea : Dimensions -> Int
surfaceArea dimensions =
    faceSizes dimensions
        |> sum


faceSizes : Dimensions -> List Int
faceSizes dimensions =
    [ dimensions.height * dimensions.width
    , dimensions.height * dimensions.width
    , dimensions.width * dimensions.length
    , dimensions.width * dimensions.length
    , dimensions.height * dimensions.length
    , dimensions.height * dimensions.length
    ]


volume : Dimensions -> Int
volume dimensions =
    dimensions.length * dimensions.width * dimensions.height


sum : List Int -> Int
sum =
    List.foldl (+) 0
