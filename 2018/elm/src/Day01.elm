module Day01 exposing (partOne, partTwo)

import Array exposing (Array)
import Day01.Input exposing (input)
import Set exposing (Set)


partOne : () -> Maybe String
partOne =
    \_ ->
        input
            |> List.foldl (+) 0
            |> String.fromInt
            |> Just


partTwo : () -> Maybe String
partTwo =
    \_ ->
        problemTwoStep 0
            Set.empty
            ( 0
            , input
                |> Array.fromList
            )
            |> String.fromInt
            |> Just


nextCycle : ( Int, Array a ) -> ( Maybe a, ( Int, Array a ) )
nextCycle ( index, array ) =
    case Array.get index array of
        Just i ->
            ( Just i, ( index + 1, array ) )

        _ ->
            ( Array.get 0 array
            , ( 1, array )
            )


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
