module Day15 exposing (..)

import Answer exposing (Answer(..))
import Coordinate exposing (Coordinate, down, left, right, up)
import Day15.Cave as Cave exposing (Cave, Row, Tile(..))
import Day15.Creature as Creature exposing (Class(..), Creature, CreatureCoordinate)
import Day15.Input exposing (..)
import Matrix



{--- Day 15: Beverage Bandits ---

Having perfected their hot chocolate, the Elves have a new problem: the Goblins that live in these
caves will do anything to steal it. Looks like they're here for a fight.

You scan the area, generating a map of the walls (#), open cavern (.), and starting position of
every Goblin (G) and Elf (E) (your puzzle input).

Combat proceeds in rounds; in each round, each unit that is still alive takes a turn, resolving all
of its actions before the next unit's turn begins. On each unit's turn, it tries to move into range
of an enemy (if it isn't already) and then attack (if it is in range).

All units are very disciplined and always follow very strict combat rules. Units never move or
attack diagonally, as doing so would be dishonorable. When multiple choices are equally valid, ties
are broken in reading order: top-to-bottom, then left-to-right. For instance, the order in which
units take their turns within a round is the reading order of their starting positions in that
round, regardless of the type of unit or whether other units have moved after the round started. For
example:

                   would take their
  These units:   turns in this order:
    #######           #######
    #.G.E.#           #.1.2.#
    #E.G.E#           #3.4.5#
    #.G.E.#           #.6.7.#
    #######           #######

Each unit begins its turn by identifying all possible targets (enemy units). If no targets remain,
combat ends.

Then, the unit identifies all of the open squares (.) that are in range of each target; these are
the squares which are adjacent (immediately up, down, left, or right) to any target and which aren't
already occupied by a wall or another unit. Alternatively, the unit might already be in range of a
target. If the unit is not already in range of a target, and there are no open squares which are in
range of a target, the unit ends its turn.

If the unit is already in range of a target, it does not move, but continues its turn with an
attack. Otherwise, since it is not in range of a target, it moves.

To move, the unit first considers the squares that are in range and determines which of those
squares it could reach in the fewest steps. A step is a single movement to any adjacent (immediately
up, down, left, or right) open (.) square. Units cannot move into walls or other units. The unit
does this while considering the current positions of units and does not do any prediction about
where units will be later. If the unit cannot reach (find an open path to) any of the squares that
are in range, it ends its turn. If multiple squares are in range and tied for being reachable in the
fewest steps, the square which is first in reading order is chosen. For example:

  Targets:      In range:     Reachable:    Nearest:      Chosen:
  #######       #######       #######       #######       #######
  #E..G.#       #E.?G?#       #E.@G.#       #E.!G.#       #E.+G.#
  #...#.#  -->  #.?.#?#  -->  #.@.#.#  -->  #.!.#.#  -->  #...#.#
  #.G.#G#       #?G?#G#       #@G@#G#       #!G.#G#       #.G.#G#
  #######       #######       #######       #######       #######

In the above scenario, the Elf has three targets (the three Goblins):

- Each of the Goblins has open, adjacent squares which are in range (marked with a ? on the map).
- Of those squares, four are reachable (marked @); the other two (on the right) would require moving
  through a wall or unit to reach.
- Three of these reachable squares are nearest, requiring the fewest steps (only 2) to reach
  (marked !).
- Of those, the square which is first in reading order is chosen (+).

The unit then takes a single step toward the chosen square along the shortest path to that square.
If multiple steps would put the unit equally closer to its destination, the unit chooses the step
which is first in reading order. (This requires knowing when there is more than one shortest path so
that you can consider the first step of each such path.) For example:

  In range:     Nearest:      Chosen:       Distance:     Step:
  #######       #######       #######       #######       #######
  #.E...#       #.E...#       #.E...#       #4E212#       #..E..#
  #...?.#  -->  #...!.#  -->  #...+.#  -->  #32101#  -->  #.....#
  #..?G?#       #..!G.#       #...G.#       #432G2#       #...G.#
  #######       #######       #######       #######       #######

The Elf sees three squares in range of a target (?), two of which are nearest (!), and so the first
in reading order is chosen (+). Under "Distance", each open square is marked with its distance from
the destination square; the two squares to which the Elf could move on this turn (down and to the
right) are both equally good moves and would leave the Elf 2 steps from being in range of the
Goblin. Because the step which is first in reading order is chosen, the Elf moves right one square.

Here's a larger example of movement:

  Initially:
  #########
  #G..G..G#
  #.......#
  #.......#
  #G..E..G#
  #.......#
  #.......#
  #G..G..G#
  #########

  After 1 round:
  #########
  #.G...G.#
  #...G...#
  #...E..G#
  #.G.....#
  #.......#
  #G..G..G#
  #.......#
  #########

  After 2 rounds:
  #########
  #..G.G..#
  #...G...#
  #.G.E.G.#
  #.......#
  #G..G..G#
  #.......#
  #.......#
  #########

  After 3 rounds:
  #########
  #.......#
  #..GGG..#
  #..GEG..#
  #G..G...#
  #......G#
  #.......#
  #.......#
  #########

Once the Goblins and Elf reach the positions above, they all are either in range of a target or
cannot find any square in range of a target, and so none of the units can move until a unit dies.

After moving (or if the unit began its turn in range of a target), the unit attacks.

To attack, the unit first determines all of the targets that are in range of it by being immediately
adjacent to it. If there are no such targets, the unit ends its turn. Otherwise, the adjacent target
with the fewest hit points is selected; in a tie, the adjacent target with the fewest hit points
which is first in reading order is selected.

The unit deals damage equal to its attack power to the selected target, reducing its hit points by
that amount. If this reduces its hit points to 0 or fewer, the selected target dies: its square
becomes . and it takes no further turns.

Each unit, either Goblin or Elf, has 3 attack power and starts with 200 hit points.

For example, suppose the only Elf is about to attack:

         HP:            HP:
  G....  9       G....  9
  ..G..  4       ..G..  4
  ..EG.  2  -->  ..E..
  ..G..  2       ..G..  2
  ...G.  1       ...G.  1

The "HP" column shows the hit points of the Goblin to the left in the corresponding row. The Elf is
in range of three targets: the Goblin above it (with 4 hit points), the Goblin to its right (with 2
hit points), and the Goblin below it (also with 2 hit points). Because three targets are in range,
the ones with the lowest hit points are selected: the two Goblins with 2 hit points each (one to the
right of the Elf and one below the Elf). Of those, the Goblin first in reading order (the one to the
right of the Elf) is selected. The selected Goblin's hit points (2) are reduced by the Elf's attack
power (3), reducing its hit points to -1, killing it.

After attacking, the unit's turn ends. Regardless of how the unit's turn ends, the next unit in the
round takes its turn. If all units have taken turns in this round, the round ends, and a new round
begins.

The Elves look quite outnumbered. You need to determine the outcome of the battle: the number of
full rounds that were completed (not counting the round in which combat ends) multiplied by the sum
of the hit points of all remaining units at the moment combat ends. (Combat only ends when a unit
finds no targets during its turn.)

Below is an entire sample combat. Next to each map, each row's units' hit points are listed from
left to right.

  Initially:
  #######
  #.G...#   G(200)
  #...EG#   E(200), G(200)
  #.#.#G#   G(200)
  #..G#E#   G(200), E(200)
  #.....#
  #######

  After 1 round:
  #######
  #..G..#   G(200)
  #...EG#   E(197), G(197)
  #.#G#G#   G(200), G(197)
  #...#E#   E(197)
  #.....#
  #######

  After 2 rounds:
  #######
  #...G.#   G(200)
  #..GEG#   G(200), E(188), G(194)
  #.#.#G#   G(194)
  #...#E#   E(194)
  #.....#
  #######

  Combat ensues; eventually, the top Elf dies:

  After 23 rounds:
  #######
  #...G.#   G(200)
  #..G.G#   G(200), G(131)
  #.#.#G#   G(131)
  #...#E#   E(131)
  #.....#
  #######

  After 24 rounds:
  #######
  #..G..#   G(200)
  #...G.#   G(131)
  #.#G#G#   G(200), G(128)
  #...#E#   E(128)
  #.....#
  #######

  After 25 rounds:
  #######
  #.G...#   G(200)
  #..G..#   G(131)
  #.#.#G#   G(125)
  #..G#E#   G(200), E(125)
  #.....#
  #######

  After 26 rounds:
  #######
  #G....#   G(200)
  #.G...#   G(131)
  #.#.#G#   G(122)
  #...#E#   E(122)
  #..G..#   G(200)
  #######

  After 27 rounds:
  #######
  #G....#   G(200)
  #.G...#   G(131)
  #.#.#G#   G(119)
  #...#E#   E(119)
  #...G.#   G(200)
  #######

  After 28 rounds:
  #######
  #G....#   G(200)
  #.G...#   G(131)
  #.#.#G#   G(116)
  #...#E#   E(113)
  #....G#   G(200)
  #######

  More combat ensues; eventually, the bottom Elf dies:

  After 47 rounds:
  #######
  #G....#   G(200)
  #.G...#   G(131)
  #.#.#G#   G(59)
  #...#.#
  #....G#   G(200)
  #######

Before the 48th round can finish, the top-left Goblin finds that there are no targets remaining, and
so combat ends. So, the number of full rounds that were completed is 47, and the sum of the hit
points of all remaining units is 200+131+59+200 = 590. From these, the outcome of the battle is 47 *
590 = 27730.

Here are a few example summarized combats:


  #######       #######
  #G..#E#       #...#E#   E(200)
  #E#E.E#       #E#...#   E(197)
  #G.##.#  -->  #.E##.#   E(185)
  #...#E#       #E..#E#   E(200), E(200)
  #...E.#       #.....#
  #######       #######

  Combat ends after 37 full rounds
  Elves win with 982 total hit points left
  Outcome: 37 * 982 = 36334


  #######       #######
  #E..EG#       #.E.E.#   E(164), E(197)
  #.#G.E#       #.#E..#   E(200)
  #E.##E#  -->  #E.##.#   E(98)
  #G..#.#       #.E.#.#   E(200)
  #..E#.#       #...#.#
  #######       #######

  Combat ends after 46 full rounds
  Elves win with 859 total hit points left
  Outcome: 46 * 859 = 39514


  #######       #######
  #E.G#.#       #G.G#.#   G(200), G(98)
  #.#G..#       #.#G..#   G(200)
  #G.#.G#  -->  #..#..#
  #G..#.#       #...#G#   G(95)
  #...E.#       #...G.#   G(200)
  #######       #######

  Combat ends after 35 full rounds
  Goblins win with 793 total hit points left
  Outcome: 35 * 793 = 27755


  #######       #######
  #.E...#       #.....#
  #.#..G#       #.#G..#   G(200)
  #.###.#  -->  #.###.#
  #E#G#G#       #.#.#.#
  #...#G#       #G.G#G#   G(98), G(38), G(200)
  #######       #######

  Combat ends after 54 full rounds
  Goblins win with 536 total hit points left
  Outcome: 54 * 536 = 28944


  #########       #########
  #G......#       #.G.....#   G(137)
  #.E.#...#       #G.G#...#   G(200), G(200)
  #..##..G#       #.G##...#   G(200)
  #...##..#  -->  #...##..#
  #...#...#       #.G.#...#   G(200)
  #.G...G.#       #.......#
  #.....G.#       #.......#
  #########       #########

Combat ends after 20 full rounds
Goblins win with 937 total hit points left
Outcome: 20 * 937 = 18740

-}


type alias BattleResult =
    { winningClass : Class
    , cave : Cave
    , score : Int
    }


partOne : () -> Answer String
partOne _ =
    simulateBattle 0 input
        -- |> (\result -> prettyPrintCave result.cave |> always result)
        |> .score
        |> String.fromInt
        |> Solved


partTwo : () -> Answer String
partTwo _ =
    simulateElvesWinning 3 input
        -- |> (\result -> prettyPrintCave result.cave |> always result)
        |> .score
        |> String.fromInt
        |> Solved


simulateElvesWinning : Int -> Cave -> BattleResult
simulateElvesWinning ap cave =
    let
        startingElfCount =
            cave |> Cave.allElves |> List.length

        battleResult =
            simulateBattle 0 (buffElves ap cave)
    in
    if (battleResult.cave |> Cave.allElves |> List.length) == startingElfCount then
        battleResult

    else
        simulateElvesWinning (ap + 1) cave


buffElves : Int -> Cave -> Cave
buffElves newAP cave =
    cave
        |> Cave.allElves
        |> List.foldl
            (\( elf, coordinate ) tmpCave ->
                Matrix.set coordinate (Open (Just { elf | ap = newAP })) tmpCave
            )
            cave


simulateBattle : Int -> Cave -> BattleResult
simulateBattle counter cave =
    let
        newCave : Result Cave Cave
        newCave =
            cave
                |> (Cave.allCreatures
                        >> List.foldl
                            (\creatureCoordinate resultCave ->
                                case resultCave of
                                    Err errCave ->
                                        Err errCave

                                    Ok okCave ->
                                        if Cave.isDead creatureCoordinate okCave then
                                            resultCave

                                        else
                                            resultCave
                                                |> Result.andThen (ensureEnemies creatureCoordinate)
                                                |> Result.map (moveCreature creatureCoordinate)
                                                |> Result.map (\( tmpCreatureCoordinate, tmpCave ) -> attackWith tmpCreatureCoordinate tmpCave)
                            )
                            (Ok cave)
                   )
    in
    case newCave of
        Err errCave ->
            let
                winningClass =
                    if Cave.allElves errCave |> List.isEmpty then
                        Goblin

                    else
                        Elf
            in
            { winningClass = winningClass, cave = errCave, score = counter * totalHP errCave }

        Ok okCave ->
            simulateBattle (counter + 1) okCave


ensureEnemies : CreatureCoordinate -> Cave -> Result Cave Cave
ensureEnemies ( { class }, _ ) cave =
    case class of
        Elf ->
            if cave |> Cave.allGoblins |> List.isEmpty then
                Err cave

            else
                Ok cave

        Goblin ->
            if cave |> Cave.allElves |> List.isEmpty then
                Err cave

            else
                Ok cave


battleIsFinished : Cave -> Bool
battleIsFinished cave =
    (cave |> Cave.allElves |> List.isEmpty) || (cave |> Cave.allGoblins |> List.isEmpty)


moveCreature : CreatureCoordinate -> Cave -> ( CreatureCoordinate, Cave )
moveCreature ( creature, coordinate ) cave =
    if besideEnemy creature coordinate cave then
        -- Already next to enemy
        ( ( creature, coordinate ), cave )

    else
        case pathToNearestEnemy cave ( creature, coordinate ) of
            [] ->
                -- No path to enemy
                ( ( creature, coordinate ), cave )

            next :: _ ->
                -- Path to enemy found
                ( ( creature, next ), moveCreatureToSpace ( creature, coordinate ) next cave )


moveCreatureToSpace : CreatureCoordinate -> Coordinate -> Cave -> Cave
moveCreatureToSpace ( creature, currentPosition ) newPosition cave =
    let
        creatureToMove =
            Matrix.get currentPosition cave |> Maybe.withDefault (Open Nothing)
    in
    cave
        |> Matrix.set currentPosition (Open Nothing)
        |> ensure "Space should be empty." (validMove newPosition)
        |> Matrix.set newPosition creatureToMove


pathToNearestEnemy : Cave -> CreatureCoordinate -> List Coordinate
pathToNearestEnemy cave ( creature, coordinate ) =
    breadthFirstSearchForEnemy creature [] [ [ coordinate ] ] [ coordinate ] cave
        |> List.map List.reverse
        |> List.sortBy (List.head >> Maybe.withDefault ( 99999, 99999 ) >> (\( a, b ) -> ( b, a )))
        |> List.map List.reverse
        |> List.head
        |> Maybe.withDefault []


{-| Returns all shortest paths to a space next to an enemy
-}
breadthFirstSearchForEnemy : Creature -> List (List Coordinate) -> List (List Coordinate) -> List Coordinate -> Cave -> List (List Coordinate)
breadthFirstSearchForEnemy creature checkedPaths uncheckedPaths checkedCoordinates cave =
    case ( checkedPaths, uncheckedPaths ) of
        ( [], [] ) ->
            []

        -- Searched this depth for all paths, try another layer
        ( _, [] ) ->
            breadthFirstSearchForEnemy creature [] checkedPaths checkedCoordinates cave

        ( _, headPath :: tailPaths ) ->
            case headPath of
                [] ->
                    Debug.todo "Shouldn't be possible"

                searchFrom :: _ ->
                    let
                        possibleSteps =
                            searchFrom
                                -- all directions that aren't walls
                                |> validMoves cave
                                -- excluding those already searched
                                |> List.filter (\move -> List.any ((==) move) checkedCoordinates |> not)
                    in
                    -- Found a monster?
                    case List.filter (\coordinate -> besideEnemy creature coordinate cave) possibleSteps of
                        -- No paths lead to monsters
                        [] ->
                            breadthFirstSearchForEnemy creature (List.append checkedPaths (List.map (\a -> a :: headPath) possibleSteps)) tailPaths (List.append possibleSteps checkedCoordinates) cave

                        -- Paths leads to monster
                        a ->
                            (a |> List.map ((\z -> z :: headPath) >> List.reverse >> List.tail) |> List.filterMap identity)
                                |> List.append (lastRoundDepthFirstSearchForEnemy creature tailPaths (List.append possibleSteps checkedCoordinates) cave)


lastRoundDepthFirstSearchForEnemy : Creature -> List (List Coordinate) -> List Coordinate -> Cave -> List (List Coordinate)
lastRoundDepthFirstSearchForEnemy creature uncheckedPaths checkedCoordinates cave =
    case uncheckedPaths of
        [] ->
            []

        headPath :: tailPaths ->
            case headPath of
                [] ->
                    Debug.todo "Shouldn't be possible"

                searchFrom :: _ ->
                    let
                        possibleSteps =
                            searchFrom
                                -- all directions that aren't walls
                                |> validMoves cave
                                -- excluding those already searched
                                |> List.filter (\move -> List.any ((==) move) checkedCoordinates |> not)
                    in
                    -- Found a monster?
                    case List.filter (\coordinate -> besideEnemy creature coordinate cave) possibleSteps of
                        -- No paths lead to monsters
                        [] ->
                            lastRoundDepthFirstSearchForEnemy creature tailPaths (List.append possibleSteps checkedCoordinates) cave

                        -- Paths leads to monster
                        a ->
                            (a |> List.map ((\z -> z :: headPath) >> List.reverse >> List.tail) |> List.filterMap identity)
                                |> List.append (lastRoundDepthFirstSearchForEnemy creature tailPaths (List.append possibleSteps checkedCoordinates) cave)


besideEnemy : Creature -> Coordinate -> Cave -> Bool
besideEnemy creature coordinate cave =
    neighbors coordinate
        |> List.any
            ((\a -> Matrix.get a cave)
                >> Maybe.withDefault Wall
                >> Cave.getCreature
                >> Maybe.map (isEnemyOf creature)
                >> Maybe.withDefault False
            )


creatureAt : Cave -> Coordinate -> Maybe Creature
creatureAt cave coordinate =
    case Matrix.get coordinate cave of
        Nothing ->
            Nothing

        Just Wall ->
            Nothing

        Just (Open creature) ->
            creature


isEnemyOf : Creature -> Creature -> Bool
isEnemyOf c1 c2 =
    case ( c1.class, c2.class ) of
        ( Elf, Goblin ) ->
            True

        ( Goblin, Elf ) ->
            True

        ( _, _ ) ->
            False


neighbors : Coordinate -> List Coordinate
neighbors coordinate =
    [ up coordinate
    , left coordinate
    , right coordinate
    , down coordinate
    ]


validMoves : Cave -> Coordinate -> List Coordinate
validMoves cave coordinate =
    coordinate
        |> neighbors
        |> List.filter (\c -> validMove c cave)


validMove : Coordinate -> Cave -> Bool
validMove coordinate cave =
    case Matrix.get coordinate cave of
        Just (Open Nothing) ->
            True

        _ ->
            False


ensure : String -> (a -> Bool) -> a -> a
ensure message function a =
    if function a then
        a

    else
        Debug.todo message


nextCreatureToFight : CreatureCoordinate -> Cave -> Maybe CreatureCoordinate
nextCreatureToFight ( creature, coordinate ) cave =
    neighbors coordinate
        |> List.map (\c -> ( creatureAt cave c, c ))
        |> List.filterMap
            (\( maybeCr, co ) ->
                case maybeCr of
                    Nothing ->
                        Nothing

                    Just cr ->
                        Just ( cr, co )
            )
        |> List.filter (Tuple.first >> isEnemyOf creature)
        |> List.sortBy (Tuple.first >> .hp)
        |> List.head


attackWith : CreatureCoordinate -> Cave -> Cave
attackWith creatureCoordinate1 cave =
    case nextCreatureToFight creatureCoordinate1 cave of
        Nothing ->
            cave

        Just creatureCoordinate2 ->
            attack (creatureCoordinate1 |> Tuple.first |> .ap) creatureCoordinate2 cave


attack : Int -> CreatureCoordinate -> Cave -> Cave
attack ap ( creature, coordinate ) cave =
    let
        updatedCreature =
            { creature | hp = creature.hp - ap }
    in
    cave
        |> Matrix.set coordinate
            (if Creature.isDead updatedCreature then
                Open Nothing

             else
                Open (Just updatedCreature)
            )


totalHP : Cave -> Int
totalHP cave =
    Cave.allCreatures cave
        |> List.map Tuple.first
        |> List.map .hp
        |> List.sum
