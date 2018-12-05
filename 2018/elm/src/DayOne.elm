module DayOne exposing (partOne, partTwo)

import Array exposing (Array)
import DayOne.Input exposing (input)
import Set exposing (Set)


nextCycle : ( Int, Array a ) -> ( Maybe a, ( Int, Array a ) )
nextCycle ( index, array ) =
    case Array.get index array of
        Just i ->
            ( Just i, ( index + 1, array ) )

        _ ->
            ( Array.get 0 array
            , ( 1, array )
            )


partOne : String
partOne =
    input
        |> List.foldl (+) 0
        |> String.fromInt


partTwo : String
partTwo =
    problemTwoStep 0
        Set.empty
        ( 0
        , input
            |> Array.fromList
        )
        |> String.fromInt


problemTwoStep : Int -> Set Int -> ( Int, Array Int ) -> Int
problemTwoStep currentSum pastSums cycle =
    if Set.member currentSum pastSums then
        currentSum

    else
        case nextCycle cycle of
            ( Nothing, _ ) ->
                -1

            ( Just next, rest ) ->
                problemTwoStep (currentSum + next) (Set.insert currentSum pastSums) rest
