module Day13 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Coordinate exposing (Coordinate)
import Day13.Input exposing (Cart, Heading(..), Map, Tile(..), TurnDirection(..), input)
import Matrix



{--Day 13: Mine Cart Madness ---

A crop of this size requires significant logistics to transport produce, soil, fertilizer, and so
on. The Elves are very busy pushing things around in carts on some kind of rudimentary system of
tracks they've come up with.

Seeing as how cart-and-track systems don't appear in recorded history for another 1000 years, the
Elves seem to be making this up as they go along. They haven't even figured out how to avoid
collisions yet.

You map out the tracks (your puzzle input) and see where you can help.

Tracks consist of straight paths (| and -), curves (/ and \\), and intersections (+). Curves connect
exactly two perpendicular pieces of track; for example, this is a closed loop:

  /----\
  |    |
  |    |
  \----/

Intersections occur when two perpendicular paths cross. At an intersection, a cart is capable of
turning left, turning right, or continuing straight. Here are two loops connected by two
intersections:

  /-----\
  |     |
  |  /--+--\
  |  |  |  |
  \--+--/  |
     |     |
     \-----/

Several carts are also on the tracks. Carts always face either up (^), down (v), left (<), or right
(>). (On your initial map, the track under each cart is a straight path matching the direction the
cart is facing.)

Each time a cart has the option to turn (by arriving at any intersection), it turns left the first
time, goes straight the second time, turns right the third time, and then repeats those directions
starting again with left the fourth time, straight the fifth time, and so on. This process is
independent of the particular intersection at which the cart has arrived - that is, the cart has no
per-intersection memory.

Carts all move at the same speed; they take turns moving a single step at a time. They do this based
on their current location: carts on the top row move first (acting from left to right), then carts
on the second row move (again from left to right), then carts on the third row, and so on. Once each
cart has moved one step, the process repeats; each of these loops is called a tick.

For example, suppose there are two carts on a straight track:

  |  |  |  |  |
  v  |  |  |  |
  |  v  v  |  |
  |  |  |  v  X
  |  |  ^  ^  |
  ^  ^  |  |  |
  |  |  |  |  |

First, the top cart moves. It is facing down (v), so it moves down one square. Second, the bottom
cart moves. It is facing up (^), so it moves up one square. Because all carts have moved, the first
tickOne ends. Then, the process repeats, starting with the first cart. The first cart moves down, then
the second cart moves up - right into the first cart, colliding with it! (The location of the crash
is marked with an X.) This ends the second and last tick.

Here is a longer example:

  /->-\
  |   |  /----\
  | /-+--+-\  |
  | | |  | v  |
  \-+-/  \-+--/
    \------/

  /-->\
  |   |  /----\
  | /-+--+-\  |
  | | |  | |  |
  \-+-/  \->--/
    \------/

  /---v
  |   |  /----\
  | /-+--+-\  |
  | | |  | |  |
  \-+-/  \-+>-/
    \------/

  /---\
  |   v  /----\
  | /-+--+-\  |
  | | |  | |  |
  \-+-/  \-+->/
    \------/

  /---\
  |   |  /----\
  | /->--+-\  |
  | | |  | |  |
  \-+-/  \-+--^
    \------/

  /---\
  |   |  /----\
  | /-+>-+-\  |
  | | |  | |  ^
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /----\
  | /-+->+-\  ^
  | | |  | |  |
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /----<
  | /-+-->-\  |
  | | |  | |  |
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /---<\
  | /-+--+>\  |
  | | |  | |  |
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /--<-\
  | /-+--+-v  |
  | | |  | |  |
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /-<--\
  | /-+--+-\  |
  | | |  | v  |
  \-+-/  \-+--/
    \------/

  /---\
  |   |  /<---\
  | /-+--+-\  |
  | | |  | |  |
  \-+-/  \-<--/
    \------/

  /---\
  |   |  v----\
  | /-+--+-\  |
  | | |  | |  |
  \-+-/  \<+--/
    \------/

  /---\
  |   |  /----\
  | /-+--v-\  |
  | | |  | |  |
  \-+-/  ^-+--/
    \------/

  /---\
  |   |  /----\
  | /-+--+-\  |
  | | |  X |  |
  \-+-/  \-+--/
    \------/

After following their respective paths for a while, the carts eventually crash. To help prevent
crashes, you'd like to know the location of the first crash. Locations are given in X,Y coordinates,
where the furthest left column is X=0 and the furthest top row is Y=0:

             111
   0123456789012
  0/---\
  1|   |  /----\
  2| /-+--+-\  |
  3| | |  X |  |
  4\-+-/  \-+--/
  5  \------/

In this example, the location of the first crash is 7,3.

-}


partOne : () -> Answer String
partOne _ =
    input
        |> simulateCrash
        |> coordinateToString
        |> Solved


partTwo : () -> Answer String
partTwo _ =
    input
        |> simulateAllCrashes
        |> coordinateToString
        |> Solved


coordinateToString : Coordinate -> String
coordinateToString ( x, y ) =
    String.fromInt x
        ++ ","
        ++ String.fromInt y


simulateCrash : Map -> Coordinate
simulateCrash map =
    case tickOne map of
        Safe carts ->
            simulateCrash { map | carts = carts }

        Crash location ->
            location


simulateAllCrashes : Map -> Coordinate
simulateAllCrashes map =
    case tickTwo map of
        One cart ->
            cart.coordinate

        Many carts ->
            simulateAllCrashes { map | carts = carts }


type TickResult a
    = Safe a
    | Crash Coordinate


type CrashesResult
    = Many (List Cart)
    | One Cart


tickOne : Map -> TickResult (List Cart)
tickOne map =
    map.carts
        |> sortCarts
        |> tickOneHelper map []


{-| maps a list of individual tickOne results into a list tickOne result -
-}
tickOneHelper : Map -> List Cart -> List Cart -> TickResult (List Cart)
tickOneHelper map checked toCheck =
    case toCheck of
        [] ->
            Safe checked

        cart :: tail ->
            case tickCart map (List.append checked tail) cart of
                Safe tickedCart ->
                    tickOneHelper map (tickedCart :: checked) tail

                Crash location ->
                    Crash location


tickTwo : Map -> CrashesResult
tickTwo map =
    map.carts
        |> sortCarts
        |> tickTwoHelper map []


{-| maps a list of individual tickOne results into a list tickOne result -
-}
tickTwoHelper : Map -> List Cart -> List Cart -> CrashesResult
tickTwoHelper map checked toCheck =
    case toCheck of
        [] ->
            case checked of
                cart :: [] ->
                    One cart

                _ ->
                    Many checked

        cart :: tail ->
            case tickCart map (List.append checked tail) cart of
                Safe tickedCart ->
                    tickTwoHelper map (tickedCart :: checked) tail

                Crash location ->
                    tickTwoHelper map (removeCrash location checked) (removeCrash location tail)


removeCrash : Coordinate -> List Cart -> List Cart
removeCrash coordinate =
    List.filter (.coordinate >> (/=) coordinate)


{-| tickCart moves a single cart one tickOne forwards.

This will do the following:

  - Move the cart in the current direction.
  - Determine a new direction (if required).
  - Detect collisions

-}
tickCart : Map -> List Cart -> Cart -> TickResult Cart
tickCart map listCart cart =
    cart
        |> moveCart
        |> turnCart map
        |> detectCrash listCart


moveCart : Cart -> Cart
moveCart cart =
    { cart
        | coordinate =
            case cart.heading of
                North ->
                    ( Tuple.first cart.coordinate
                    , Tuple.second cart.coordinate - 1
                    )

                South ->
                    ( Tuple.first cart.coordinate
                    , Tuple.second cart.coordinate + 1
                    )

                East ->
                    ( Tuple.first cart.coordinate + 1
                    , Tuple.second cart.coordinate
                    )

                West ->
                    ( Tuple.first cart.coordinate - 1
                    , Tuple.second cart.coordinate
                    )
    }


turnCart : Map -> Cart -> Cart
turnCart map cart =
    let
        tile =
            Matrix.get cart.coordinate map.tiles |> Maybe.withDefault Empty
    in
    if tile == Intersection then
        handleIntersection cart

    else if tile |> isCorner then
        handleCorner tile cart

    else
        cart


isCorner : Tile -> Bool
isCorner tile =
    [ BottomToLeft, TopToLeft, BottomToRight, TopToRight ]
        |> List.any ((==) tile)


handleCorner : Tile -> Cart -> Cart
handleCorner tile cart =
    case ( tile, cart.heading ) of
        ( BottomToLeft, East ) ->
            { cart | heading = South }

        ( BottomToLeft, North ) ->
            { cart | heading = West }

        ( TopToLeft, East ) ->
            { cart | heading = North }

        ( TopToLeft, South ) ->
            { cart | heading = West }

        ( BottomToRight, West ) ->
            { cart | heading = South }

        ( BottomToRight, North ) ->
            { cart | heading = East }

        ( TopToRight, West ) ->
            { cart | heading = North }

        ( TopToRight, South ) ->
            { cart | heading = East }

        _ ->
            Debug.todo "Bad Corner!"


handleIntersection : Cart -> Cart
handleIntersection cart =
    case ( cart.heading, cart.nextTurn ) of
        ( North, Left ) ->
            { cart | heading = West, nextTurn = Straight }

        ( South, Left ) ->
            { cart | heading = East, nextTurn = Straight }

        ( East, Left ) ->
            { cart | heading = North, nextTurn = Straight }

        ( West, Left ) ->
            { cart | heading = South, nextTurn = Straight }

        ( North, Straight ) ->
            { cart | heading = North, nextTurn = Right }

        ( South, Straight ) ->
            { cart | heading = South, nextTurn = Right }

        ( East, Straight ) ->
            { cart | heading = East, nextTurn = Right }

        ( West, Straight ) ->
            { cart | heading = West, nextTurn = Right }

        ( North, Right ) ->
            { cart | heading = East, nextTurn = Left }

        ( South, Right ) ->
            { cart | heading = West, nextTurn = Left }

        ( East, Right ) ->
            { cart | heading = South, nextTurn = Left }

        ( West, Right ) ->
            { cart | heading = North, nextTurn = Left }


detectCrash : List Cart -> Cart -> TickResult Cart
detectCrash listCart cart =
    case listCart of
        [] ->
            Safe cart

        possibleCollision :: remainingCarts ->
            if possibleCollision.coordinate == cart.coordinate then
                Crash cart.coordinate

            else
                detectCrash remainingCarts cart


sortCarts : List Cart -> List Cart
sortCarts cartList =
    cartList
        |> List.sortBy .coordinate
