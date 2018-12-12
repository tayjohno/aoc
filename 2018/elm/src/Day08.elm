module Day08 exposing (partOne, partTwo, readNode, readNodes)

import Day08.Input exposing (input)
import Day08.Node as Node exposing (Node(..))


type alias MetadataNode =
    Node (List Int)


partOne : Maybe String
partOne =
    readNode input
        |> Tuple.first
        |> Node.flatten
        |> List.map Node.data
        |> List.map (List.foldl (+) 0)
        |> List.foldl (+) 0
        |> String.fromInt
        |> Just


readNodes : Int -> List Int -> ( List MetadataNode, List Int )
readNodes n intList =
    ( [ Node [] [] ], [] )


readNode : List Int -> ( MetadataNode, List Int )
readNode intList =
    let
        childLength =
            List.head intList

        metaLength =
            List.head (Maybe.withDefault [] (List.tail intList))
    in
    ( Node [] [], [] )


partTwo : Maybe String
partTwo =
    Nothing
