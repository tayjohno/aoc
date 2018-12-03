module DayOne exposing (inputString, nextCycle, parseInput, parseNumberString, problemOne, problemTwo)

import Array exposing (Array)
import DayOneInput exposing (input)
import Set exposing (Set)


parseNumberString : String -> Maybe Int
parseNumberString input =
    case String.uncons input of
        Just ( '+', num ) ->
            String.toInt num

        Just ( '-', num ) ->
            String.toInt num
                |> Maybe.andThen (Just << negate)

        _ ->
            Nothing


nextCycle : ( Int, Array a ) -> ( Maybe a, ( Int, Array a ) )
nextCycle ( index, array ) =
    case Array.get index array of
        Just i ->
            ( Just i, ( index + 1, array ) )

        _ ->
            ( Array.get 0 array
            , ( 1, array )
            )


problemOne : Int
problemOne =
    inputString
        |> parseInput
        |> List.foldl (+) 0


problemTwo : Maybe Int
problemTwo =
    problemTwoStep 0
        Set.empty
        ( 0
        , inputString
            |> parseInput
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
