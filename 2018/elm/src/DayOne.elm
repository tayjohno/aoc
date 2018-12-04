module DayOne exposing (partOne, partTwo)

import Array exposing (Array)
import DayOneInput exposing (input)
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


partOne : Int
partOne =
    input
        |> List.foldl (+) 0


partTwo : Maybe Int
partTwo =
    problemTwoStep 0
        Set.empty
        ( 0
        , input
            |> Array.fromList
        )


problemTwoStep : Int -> Set Int -> ( Int, Array Int ) -> Maybe Int
problemTwoStep currentSum pastSums cycle =
    if Set.member currentSum pastSums then
        Just currentSum

    else
        case nextCycle cycle of
            ( Nothing, _ ) ->
                Nothing

            ( Just next, rest ) ->
                problemTwoStep (currentSum + next) (Set.insert currentSum pastSums) rest
