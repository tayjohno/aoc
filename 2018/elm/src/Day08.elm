module Day08 exposing (partOne, partTwo, readNode, readNodes)

import Answer exposing (Answer(..))
import Day08.Input exposing (input)
import Day08.Node as Node exposing (Node(..))


type alias MetadataNode =
    Node (List Int)


partOne : () -> Answer String
partOne =
    \_ ->
        readNode input
            |> Tuple.first
            |> Node.flatten
            |> List.map Node.data
            |> List.map (List.foldl (+) 0)
            |> List.foldl (+) 0
            |> String.fromInt
            |> Solved


partTwo : () -> Answer String
partTwo =
    \_ ->
        readNode input
            |> Tuple.first
            |> nodeValue
            |> String.fromInt
            |> Solved


readNodes : Int -> List Int -> ( List MetadataNode, List Int )
readNodes n intList =
    if n == 0 then
        ( [], intList )

    else
        let
            ( nextNode, remainingList ) =
                readNode intList

            ( otherNodes, finalList ) =
                readNodes (n - 1) remainingList
        in
        ( nextNode :: otherNodes, finalList )


readNode : List Int -> ( MetadataNode, List Int )
readNode intList =
    case intList of
        childLength :: metaLength :: remainderInput ->
            let
                ( childNodes, remainderOutput ) =
                    readNodes childLength remainderInput
            in
            ( Node childNodes (List.take metaLength remainderOutput), List.drop metaLength remainderOutput )

        _ ->
            Debug.todo "Oops!"


nodeValue : MetadataNode -> Int
nodeValue (Node children metadata) =
    if children == [] then
        metadata
            |> List.foldl (+) 0

    else
        metadata
            |> List.filterMap (\a -> atIndex (a - 1) children)
            |> List.map nodeValue
            |> List.foldl (+) 0


atIndex : Int -> List a -> Maybe a
atIndex i =
    List.drop i
        >> List.head
