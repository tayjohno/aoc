module Day12 exposing (..)

import Answer exposing (Answer(..))
import Day12.Input exposing (Neighbors, Planter(..), Row, Rule, input, printPlanter, printRow, printRule, ruleSet)



{--Day 12: Subterranean Sustainability ---

The year 518 is significantly more underground than your history books implied. Either that, or
you've arrived in a vast cavern network under the North Pole.

After exploring a little, you discover a long tunnel that contains a row of small pots as far as you
can see to your left and right. A few of them contain plantes - someone is trying to grow things in
these geothermally-heated caves.

The pots are numbered, with 0 in front of you. To the left, the pots are numbered -1, -2, -3, and so
on; to the right, 1, 2, 3.... Your puzzle input contains a list of pots from 0 to the right and
whether they do (#) or do not (.) currently contain a plant, the initial state. (No other pots
currently contain plants.) For example, an initial state of #..##.... indicates that pots 0, 3, and
4 currently contain plants.

Your puzzle input also contains some notes you find on a nearby table: someone has been trying to
figure out how these plants spread to nearby pots. Based on the notes, for each generation of
plants, a given pot has or does not have a plant based on whether that pot (and the two pots on
either side of it) had a plant in the last generation. These are written as LLCRR => N, where L are
pots to the left, C is the current pot being considered, R are the pots to the right, and N is
whether the current pot will have a plant in the next generation. For example:

A note like ..#.. => . means that a pot that contains a plant but with no plants within two pots of
it will not have a plant in it during the next generation.

A note like ##.## => . means that an empty pot with two plants on each side of it will remain empty
in the next generation.

A note like .##.# => # means that a pot has a plant in a given generation if, in the previous
generation, there were plants in that pot, the one immediately to the left, and the one two pots to
the right, but not in the ones immediately to the right and two to the left.

It's not clear what these plants are for, but you're sure it's important, so you'd like to make sure
the current configuration of plants is sustainable by determining what will happen after 20
generations.

For example, given the following input:

initial state: #..#.#..##......###...###

  ...## => #
  ..#.. => #
  .#... => #
  .#.#. => #
  .#.## => #
  .##.. => #
  .#### => #
  #.#.# => #
  #.### => #
  ##.#. => #
  ##.## => #
  ###.. => #
  ###.# => #
  ####. => #

For brevity, in this example, only the combinations which do produce a plant are listed. (Your input
includes all possible combinations.) Then, the next 20 generations will look like this:

                   1         2         3
         0         0         0         0
   0: ...#..#.#..##......###...###...........
   1: ...#...#....#.....#..#..#..#...........
   2: ...##..##...##....#..#..#..##..........
   3: ..#.#...#..#.#....#..#..#...#..........
   4: ...#.#..#...#.#...#..#..##..##.........
   5: ....#...##...#.#..#..#...#...#.........
   6: ....##.#.#....#...#..##..##..##........
   7: ...#..###.#...##..#...#...#...#........
   8: ...#....##.#.#.#..##..##..##..##.......
   9: ...##..#..#####....#...#...#...#.......
  10: ..#.#..#...#.##....##..##..##..##......
  11: ...#...##...#.#...#.#...#...#...#......
  12: ...##.#.#....#.#...#.#..##..##..##.....
  13: ..#..###.#....#.#...#....#...#...#.....
  14: ..#....##.#....#.#..##...##..##..##....
  15: ..##..#..#.#....#....#..#.#...#...#....
  16: .#.#..#...#.#...##...#...#.#..##..##...
  17: ..#...##...#.#.#.#...##...#....#...#...
  18: ..##.#.#....#####.#.#.#...##...##..##..
  19: .#..###.#..#.#.#######.#.#.#..#.#...#..
  20: .#....##....#####...#######....#.#..##.

The generation is shown along the left, where 0 is the initial state. The pot numbers are shown
along the top, where 0 labels the center pot, negative-numbered pots extend to the left, and
positive pots extend toward the right. Remember, the initial state begins at pot 0, which is not the
leftmost pot used in this example.

After one generation, only seven plants remain. The one in pot 0 matched the rule looking for ..#..,
the one in pot 4 matched the rule looking for .#.#., pot 9 matched .##.., and so on.

In this example, after 20 generations, the pots shown as # contain plants, the furthest left of
which is pot -2, and the furthest right of which is pot 34. Adding up all the numbers of
plant-containing pots after the 20th generation produces 325.

After 20 generations, what is the sum of the numbers of all pots which contain a plant?
-}


partOne : () -> Answer String
partOne _ =
    input
        |> helper 20
        |> String.fromInt
        |> Solved


partTwo : () -> Answer String
partTwo _ =
    input
        |> helper 50000000000
        |> String.fromInt
        |> Solved


performGeneration : List Rule -> Row -> Row
performGeneration rules row =
    -- let
    --     _ =
    --         row.planters |> printRow |> Debug.log (String.fromInt row.index)
    -- in
    { index = row.index - 1
    , planters =
        generationHelper rules
            (List.append row.planters [ NoPlant, NoPlant, NoPlant ] |> List.append [ NoPlant, NoPlant, NoPlant ])
    }
        |> compact


generationHelper : List Rule -> List Planter -> List Planter
generationHelper ruleList planterList =
    case ( nextNeighbors planterList, planterList ) of
        ( Result.Ok neighbors, a :: tail ) ->
            lookupRule ruleList neighbors :: generationHelper ruleList tail

        ( Result.Ok neighbors, [] ) ->
            lookupRule ruleList neighbors :: planterList

        ( Result.Err _, tail ) ->
            []


nextNeighbors : List Planter -> Result String Neighbors
nextNeighbors planterList =
    case planterList of
        a :: b :: c :: d :: e :: rest ->
            Result.Ok { ll = a, l = b, c = c, r = d, rr = e }

        _ ->
            Result.Err "No Neighbors Left"


compact : Row -> Row
compact row =
    case row.planters of
        NoPlant :: tail ->
            compact { index = row.index + 1, planters = tail }

        _ ->
            { row | planters = List.reverse (removeLeading NoPlant (List.reverse row.planters)) }


removeLeading : a -> List a -> List a
removeLeading a aList =
    case aList of
        [] ->
            []

        head :: tail ->
            if head == a then
                removeLeading a tail

            else
                aList


lookupRule : List Rule -> Neighbors -> Planter
lookupRule rules neighbors =
    case rules of
        [] ->
            NoPlant

        head :: tail ->
            if head.neighbors == neighbors then
                head.output

            else
                lookupRule tail neighbors


sum : Row -> Int
sum row =
    case row.planters of
        [] ->
            0

        NoPlant :: tail ->
            sum { index = row.index + 1, planters = tail }

        Plant :: tail ->
            row.index + sum { index = row.index + 1, planters = tail }


helper : Int -> Row -> Int
helper iterations row =
    if iterations == 0 then
        sum row

    else
        let
            nextRow =
                performGeneration ruleSet row
        in
        case loopDistance row nextRow of
            Nothing ->
                helper (iterations - 1) nextRow

            Just i ->
                sum row + iterations * plantCount row


plantCount : Row -> Int
plantCount row =
    row.planters
        |> List.foldl
            (\a ->
                if a == Plant then
                    (+) 1

                else
                    identity
            )
            0


loopDistance : Row -> Row -> Maybe Int
loopDistance row1 row2 =
    if row1.planters == row2.planters then
        Just (row2.index - row1.index)

    else
        Nothing
