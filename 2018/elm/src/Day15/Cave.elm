module Day15.Cave exposing (Cave, Row, Tile(..), allCreatures, allElves, allGoblins, getCreature, isDead)

import Day15.Creature as Creature exposing (Class(..), Creature, CreatureCoordinate)
import Matrix exposing (Matrix)


type alias Cave =
    Matrix Tile


type Tile
    = Open (Maybe Creature)
    | Wall


type alias Row =
    List Tile


getCreature : Tile -> Maybe Creature
getCreature tile =
    case tile of
        Wall ->
            Nothing

        Open creature ->
            creature


allElves : Cave -> List CreatureCoordinate
allElves cave =
    allCreatures cave
        |> List.filter (\( { class }, _ ) -> class == Elf)


allGoblins : Cave -> List CreatureCoordinate
allGoblins cave =
    allCreatures cave
        |> List.filter (\( { class }, _ ) -> class == Goblin)


allCreatures : Cave -> List CreatureCoordinate
allCreatures cave =
    cave
        |> Matrix.findAll
            (\tile ->
                case tile of
                    Open (Just _) ->
                        True

                    _ ->
                        False
            )
        |> List.map (\( tile, coordinate ) -> ( getCreature tile, coordinate ))
        |> List.filterMap
            (\( maybeCreature, coordinate ) ->
                case maybeCreature of
                    Nothing ->
                        Nothing

                    Just creature ->
                        Just ( creature, coordinate )
            )
        |> List.reverse


isDead : CreatureCoordinate -> Cave -> Bool
isDead ( creature, coordinate ) cave =
    if creature |> Creature.isDead then
        True

    else
        case cave |> Matrix.get coordinate of
            Nothing ->
                Debug.todo "Out of boundsf?"

            Just Wall ->
                Debug.todo "Wall cannot be alive or dead?"

            Just (Open Nothing) ->
                True

            Just (Open (Just foundCreature)) ->
                if foundCreature.startingCoordinate /= creature.startingCoordinate then
                    True

                else
                    False
