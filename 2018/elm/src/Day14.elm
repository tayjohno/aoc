module Day14 exposing (partOne, partTwo)

import Array exposing (Array)



{--- Day 14: Chocolate Charts ---

You finally have a chance to look at all of the produce moving around. Chocolate, cinnamon, mint,
chili peppers, nutmeg, vanilla... the Elves must be growing these plants to make hot chocolate! As
you realize this, you hear a conversation in the distance. When you go to investigate, you discover
two Elves in what appears to be a makeshift underground kitchen/laboratory.

The Elves are trying to come up with the ultimate hot chocolate recipe; they're even maintaining a
scoreboard which tracks the quality score (0-9) of each recipe.

Only two recipes are on the board: the first recipe got a score of 3, the second, 7. Each of the two
Elves has a current recipe: the first Elf starts with the first recipe, and the second Elf starts
with the second recipe.

To create new recipes, the two Elves combine their current recipes. This creates new recipes from
the digits of the sum of the current recipes' scores. With the current recipes' scores of 3 and 7,
their sum is 10, and so two new recipes would be created: the first with score 1 and the second with
score 0. If the current recipes' scores were 2 and 3, the sum, 5, would only create one recipe (with
a score of 5) with its single digit.

The new recipes are added to the end of the scoreboard in the order they are created. So, after the
first round, the scoreboard is 3, 7, 1, 0.

After all new recipes are added to the scoreboard, each Elf picks a new current recipe. To do this,
the Elf steps forward through the scoreboard a number of recipes equal to 1 plus the score of their
current recipe. So, after the first round, the first Elf moves forward 1 + 3 = 4 times, while the
second Elf moves forward 1 + 7 = 8 times. If they run out of recipes, they loop back around to the
beginning. After the first round, both Elves happen to loop around until they land on the same
recipe that they had in the beginning; in general, they will move to different recipes.

Drawing the first Elf as parentheses and the second Elf as square brackets, they continue this
process:

  (3)[7]
  (3)[7] 1  0
   3  7  1 [0](1) 0
   3  7  1  0 [1] 0 (1)
  (3) 7  1  0  1  0 [1] 2
   3  7  1  0 (1) 0  1  2 [4]
   3  7  1 [0] 1  0 (1) 2  4  5
   3  7  1  0 [1] 0  1  2 (4) 5  1
   3 (7) 1  0  1  0 [1] 2  4  5  1  5
   3  7  1  0  1  0  1  2 [4](5) 1  5  8
   3 (7) 1  0  1  0  1  2  4  5  1  5  8 [9]
   3  7  1  0  1  0  1 [2] 4 (5) 1  5  8  9  1  6
   3  7  1  0  1  0  1  2  4  5 [1] 5  8  9  1 (6) 7
   3  7  1  0 (1) 0  1  2  4  5  1  5 [8] 9  1  6  7  7
   3  7 [1] 0  1  0 (1) 2  4  5  1  5  8  9  1  6  7  7  9
   3  7  1  0 [1] 0  1  2 (4) 5  1  5  8  9  1  6  7  7  9  2

The Elves think their skill will improve after making a few recipes (your puzzle input). However,
that could take ages; you can speed this up considerably by identifying the scores of the ten
recipes after that. For example:

If the Elves think their skill will improve after making 9 recipes, the scores of the ten recipes
after the first nine on the scoreboard would be 5158916779 (highlighted in the last line of the
diagram).

After 5 recipes, the scores of the next ten would be 0124515891.

After 18 recipes, the scores of the next ten would be 9251071085.

After 2018 recipes, the scores of the next ten would be 5941429882.

What are the scores of the ten recipes immediately after the number of recipes in your puzzle input?

Your puzzle input is 633601.

--}


type alias State =
    { scores : String
    , elfA : Int
    , elfB : Int
    }


input : Int
input =
    633601


{-| Array.initialize input(always Nothing)
-}
partOne : () -> Maybe String
partOne _ =
    { scores = "37", elfA = 0, elfB = 1 }
        |> simulateOne input
        |> Just


partTwo : Maybe Int -> Maybe String
partTwo maybeInt =
    let
        problemInput =
            case maybeInt of
                Just i ->
                    i

                Nothing ->
                    input
    in
    { scores = "37", elfA = 0, elfB = 1 }
        |> simulateTwo problemInput
        |> String.fromInt
        |> Just


simulateOne : Int -> State -> String
simulateOne int state =
    if String.length state.scores >= (int + 10) then
        String.slice int (int + 10) state.scores

    else
        simulateOne int (tick state)


simulateTwo : Int -> State -> Int
simulateTwo int state =
    case String.indexes (String.fromInt int) (String.right 20000 state.scores) of
        index :: _ ->
            case String.indexes (String.fromInt int) state.scores of
                i :: _ ->
                    i

                _ ->
                    Debug.todo "Should be impossible"

        _ ->
            simulateTwo int (times 10000 tick state)


times : Int -> (a -> a) -> a -> a
times int function a =
    case int of
        0 ->
            a

        _ ->
            times (int - 1) function (function a)


tick : State -> State
tick state =
    let
        _ =
            if String.length state.scores |> remainderBy 1000 |> (==) 0 then
                Debug.log "length" (String.length state.scores)

            else
                0

        aScore =
            state.scores
                |> String.slice state.elfA (state.elfA + 1)
                |> String.toInt
                |> assert

        bScore =
            state.scores
                |> String.slice state.elfB (state.elfB + 1)
                |> String.toInt
                |> assert

        newScores =
            aScore
                + bScore
                |> String.fromInt
                |> String.append state.scores
    in
    { scores = newScores
    , elfA = remainderBy (String.length newScores) (state.elfA + aScore + 1)
    , elfB = remainderBy (String.length newScores) (state.elfB + bScore + 1)
    }


assert : Maybe a -> a
assert aMaybe =
    case aMaybe of
        Just a ->
            a

        Nothing ->
            Debug.todo "oops!"
