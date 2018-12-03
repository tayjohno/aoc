module DayThree exposing (partOne, partTwo)

import DayThreeInput exposing (Direction(..), input)
import Set exposing (Set)


type alias Position =
    { x : Int, y : Int }


type alias Gps =
    { santa : Position, robot : Position }


type alias HomeAddress =
    String


partOne =
    visitedHouses startingPosition input Set.empty
        |> Set.size


partTwo =
    pairVisitedHouses
        { santa = startingPosition, robot = startingPosition }
        input
        Set.empty
        |> Set.size


startingPosition =
    { x = 0, y = 0 }



-- For Part 1


visitedHouses : Position -> List Direction -> Set HomeAddress -> Set HomeAddress
visitedHouses pos directions homeAddressSet =
    case directions of
        [] ->
            Set.insert (serializePosition pos) homeAddressSet

        nextDirection :: remainingDirections ->
            visitedHouses
                (move pos nextDirection)
                remainingDirections
                (Set.insert (serializePosition pos) homeAddressSet)



-- For Part 2


pairVisitedHouses : Gps -> List Direction -> Set HomeAddress -> Set HomeAddress
pairVisitedHouses gps directions homeAddressSet =
    case directions of
        santaDirection :: robotDirection :: remainingDirections ->
            pairVisitedHouses
                { santa = move gps.santa santaDirection, robot = move gps.robot robotDirection }
                remainingDirections
                (insertBothPositions gps homeAddressSet)

        -- Only 1 direction left.
        santaDirection :: remainingDirections ->
            pairVisitedHouses
                { santa = move gps.santa santaDirection, robot = gps.robot }
                remainingDirections
                (insertBothPositions gps homeAddressSet)

        -- No directions left
        [] ->
            insertBothPositions gps homeAddressSet


insertBothPositions : Gps -> Set HomeAddress -> Set HomeAddress
insertBothPositions gps homeAddressSet =
    homeAddressSet
        |> Set.insert (serializePosition gps.santa)
        |> Set.insert (serializePosition gps.robot)


serializePosition : Position -> HomeAddress
serializePosition position =
    String.fromInt position.x ++ "x" ++ String.fromInt position.y


move : Position -> Direction -> Position
move pos dir =
    case dir of
        North ->
            { x = pos.x, y = pos.y + 1 }

        South ->
            { x = pos.x, y = pos.y - 1 }

        East ->
            { x = pos.x + 1, y = pos.y }

        West ->
            { x = pos.x - 1, y = pos.y }
