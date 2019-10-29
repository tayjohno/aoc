module Day17 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Array2DMatrix as Matrix exposing (Coordinate)
import Day17.Input exposing (Map, Tile(..), WaterStatus(..), input, prettyPrintMap)
import Set



{--- Day 17: Reservoir Research ---

You arrive in the year 18. If it weren't for the coat you got in 1018, you would be very cold: the
North Pole base hasn't even been constructed.

Rather, it hasn't been constructed yet. The Elves are making a little progress, but there's not a
lot of liquid water in this climate, so they're getting very dehydrated. Maybe there's more
underground?

You scan a two-dimensional vertical slice of the ground nearby and discover that it is mostly sand
with veins of clay. The scan only provides data with a granularity of square meters, but it should
be good enough to determine how much water is trapped there. In the scan, x represents the distance
to the right, and y represents the distance down. There is also a spring of water near the surface
at x=500, y=0. The scan identifies which square meters are clay (your puzzle input).

For example, suppose your scan shows the following veins of clay:

  x=495, y=2..7
  y=7, x=495..501
  x=501, y=3..7
  x=498, y=2..4
  x=506, y=1..2
  x=498, y=10..13
  x=504, y=10..13
  y=13, x=498..504

Rendering clay as #, sand as ., and the water spring as +, and with x increasing to the right and y
increasing downward, this becomes:

     44444455555555
     99999900000000
     45678901234567
   0 ......+.......
   1 ............#.
   2 .#..#.......#.
   3 .#..#..#......
   4 .#..#..#......
   5 .#.....#......
   6 .#.....#......
   7 .#######......
   8 ..............
   9 ..............
  10 ....#.....#...
  11 ....#.....#...
  12 ....#.....#...
  13 ....#######...

The spring of water will produce water forever. Water can move through sand, but is blocked by clay.
Water always moves down when possible, and spreads to the left and right otherwise, filling space
that has clay on both sides and falling out otherwise.

For example, if five squares of water are created, they will flow downward until they reach the clay
and settle there. Water that has come to rest is shown here as ~, while sand through which water has
passed (but which is now dry again) is shown as |:

  ......+.......
  ......|.....#.
  .#..#.|.....#.
  .#..#.|#......
  .#..#.|#......
  .#....|#......
  .#~~~~~#......
  .#######......
  ..............
  ..............
  ....#.....#...
  ....#.....#...
  ....#.....#...
  ....#######...

Two squares of water can't occupy the same location. If another five squares of water are created,
they will settle on the first five, filling the clay reservoir a little more:

  ......+.......
  ......|.....#.
  .#..#.|.....#.
  .#..#.|#......
  .#..#.|#......
  .#~~~~~#......
  .#~~~~~#......
  .#######......
  ..............
  ..............
  ....#.....#...
  ....#.....#...
  ....#.....#...
  ....#######...

Water pressure does not apply in this scenario. If another four squares of water are created, they
will stay on the right side of the barrier, and no water will reach the left side:

  ......+.......
  ......|.....#.
  .#..#.|.....#.
  .#..#~~#......
  .#..#~~#......
  .#~~~~~#......
  .#~~~~~#......
  .#######......
  ..............
  ..............
  ....#.....#...
  ....#.....#...
  ....#.....#...
  ....#######...

At this point, the top reservoir overflows. While water can reach the tiles above the surface of the
water, it cannot settle there, and so the next five squares of water settle like this:

  ......+.......
  ......|.....#.
  .#..#||||...#.
  .#..#~~#|.....
  .#..#~~#|.....
  .#~~~~~#|.....
  .#~~~~~#|.....
  .#######|.....
  ........|.....
  ........|.....
  ....#...|.#...
  ....#...|.#...
  ....#~~~~~#...
  ....#######...

Note especially the leftmost |: the new squares of water can reach this tile, but cannot stop there.
Instead, eventually, they all fall to the right and settle in the reservoir below.

After 10 more squares of water, the bottom reservoir is also full:

  ......+.......
  ......|.....#.
  .#..#||||...#.
  .#..#~~#|.....
  .#..#~~#|.....
  .#~~~~~#|.....
  .#~~~~~#|.....
  .#######|.....
  ........|.....
  ........|.....
  ....#~~~~~#...
  ....#~~~~~#...
  ....#~~~~~#...
  ....#######...

Finally, while there is nowhere left for the water to settle, it can reach a few more tiles before
overflowing beyond the bottom of the scanned data:

  ......+.......    (line not counted: above minimum y value)
  ......|.....#.
  .#..#||||...#.
  .#..#~~#|.....
  .#..#~~#|.....
  .#~~~~~#|.....
  .#~~~~~#|.....
  .#######|.....
  ........|.....
  ...|||||||||..
  ...|#~~~~~#|..
  ...|#~~~~~#|..
  ...|#~~~~~#|..
  ...|#######|..
  ...|.......|..    (line not counted: below maximum y value)
  ...|.......|..    (line not counted: below maximum y value)
  ...|.......|..    (line not counted: below maximum y value)

How many tiles can be reached by the water? To prevent counting forever, ignore tiles with a y
coordinate smaller than the smallest y coordinate in your scan data or larger than the largest one.
Any x coordinate is valid. In this example, the lowest y coordinate given is 1, and the highest is
13, causing the water spring (in row 0) and the water falling off the bottom of the render (in rows
14 through infinity) to be ignored.

So, in the example above, counting both water at rest (~) and other sand tiles the water can
hypothetically reach (|), the total number of tiles the water can reach is 57.

How many tiles can the water reach within the range of y values in your scan?

--}


partOne : () -> Answer String
partOne _ =
    let
        ( inputMap, inputFlows ) =
            input
    in
    partOneHelper ( inputMap, inputFlows )
        |> countAllWater
        |> String.fromInt
        |> Solved


partOneHelper : ( Map, List Coordinate ) -> Map
partOneHelper ( inputMap, flows ) =
    let
        -- _ =
        --     Debug.log "flowing to..." flows
        --
        sortAndFilter =
            List.map (\( a, b ) -> ( b, a ))
                >> Set.fromList
                >> Set.toList
                >> List.map (\( a, b ) -> ( b, a ))
    in
    case flows of
        [] ->
            inputMap

        nextFlow :: tail ->
            partOneHelper (Tuple.mapSecond (List.append tail >> sortAndFilter) (flowOneStep nextFlow inputMap))


flowOneStep : Coordinate -> Map -> ( Map, List Coordinate )
flowOneStep flowCoordinate inputMap =
    let
        -- ( x, y ) =
        --     flowCoordinate |> Debug.log "flowing to"
        --
        nextCoordinates =
            if flowCoordinate |> down |> isValidFlow inputMap then
                [ flowCoordinate |> down ]

            else if flowCoordinate |> down |> isSolid inputMap then
                [ flowCoordinate |> right
                , flowCoordinate |> left
                ]
                    |> List.filter (isValidFlow inputMap)

            else
                []

        newMap =
            Matrix.set flowCoordinate (Water Flowing) inputMap
    in
    if flowCoordinate |> canOverflow inputMap then
        overflow flowCoordinate newMap

    else
        ( newMap
        , nextCoordinates
        )


{-| Returns the list of waters flowing down to this from one row above.
-}
overflow : Coordinate -> Map -> ( Map, List Coordinate )
overflow coordinate map =
    let
        {- ! find the left most point of the curently pooling water -}
        leftmost : Coordinate -> Coordinate
        leftmost c =
            if c |> left |> isSolid map then
                c

            else
                leftmost (left c)

        {- ! find all coordinates of the curently pooling water -}
        poolCoordinatesRight : Coordinate -> List Coordinate
        poolCoordinatesRight c =
            if c |> right |> isSolid map then
                [ c ]

            else
                c :: poolCoordinatesRight (right c)

        poolCoordinates : List Coordinate
        poolCoordinates =
            coordinate
                |> leftmost
                |> poolCoordinatesRight

        filledPool : Map
        filledPool =
            List.foldl (\c -> Matrix.set c (Water Settled)) map poolCoordinates

        inflows =
            poolCoordinates
                |> List.map up
                |> List.filter (\c -> Matrix.get c filledPool == Just (Water Flowing))
    in
    ( filledPool, inflows )


flip : (a -> b -> c) -> b -> a -> c
flip f b a =
    f a b


up ( x, y ) =
    ( x, y - 1 )


down ( x, y ) =
    ( x, y + 1 )


left ( x, y ) =
    ( x - 1, y )


right ( x, y ) =
    ( x + 1, y )


isValidFlow : Map -> Coordinate -> Bool
isValidFlow map coord =
    case map |> Matrix.get coord of
        Just Sand ->
            True

        _ ->
            False


isSolid : Map -> Coordinate -> Bool
isSolid map coord =
    case map |> Matrix.get coord of
        Just Clay ->
            True

        Just (Water Settled) ->
            True

        _ ->
            False


canOverflow : Map -> Coordinate -> Bool
canOverflow map coordinate =
    walledToLeft map coordinate && walledToRight map coordinate


walledToLeft : Map -> Coordinate -> Bool
walledToLeft map coordinate =
    let
        baseIsSolid =
            coordinate |> down |> isSolid map

        leftIsSolid =
            coordinate |> left |> isSolid map
    in
    if not baseIsSolid then
        False

    else if leftIsSolid then
        True

    else
        walledToLeft map (left coordinate)


walledToRight : Map -> Coordinate -> Bool
walledToRight map coordinate =
    let
        baseIsSolid =
            coordinate |> down |> isSolid map

        rightIsSolid =
            coordinate |> right |> isSolid map
    in
    if not baseIsSolid then
        False

    else if rightIsSolid then
        True

    else
        walledToRight map (right coordinate)


countAllWater : Map -> Int
countAllWater map =
    map
        |> Matrix.locations (\tile -> tile == Water Flowing || tile == Water Settled)
        |> List.length


partTwo : () -> Answer String
partTwo _ =
    let
        ( inputMap, inputFlows ) =
            input
    in
    partOneHelper ( inputMap, inputFlows )
        |> countAllSettledWater
        |> String.fromInt
        |> Solved


countAllSettledWater : Map -> Int
countAllSettledWater map =
    map
        |> Matrix.locations ((==) (Water Settled))
        |> List.length
