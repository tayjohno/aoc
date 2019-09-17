module Day15.Creature exposing (Creature(..), Stats)


type Creature
    = Elf Stats
    | Goblin Stats
    | Empty


type alias Stats =
    { ap : Int
    , hp : Int
    }
