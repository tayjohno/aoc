module Day15.Creature exposing (Class(..), Creature, CreatureCoordinate, init, isDead)

import Matrix


type alias Creature =
    { class : Class
    , ap : Int
    , hp : Int
    }


type alias CreatureCoordinate =
    ( Creature, Matrix.Coordinate )


type Class
    = Elf
    | Goblin


isDead : Creature -> Bool
isDead { hp } =
    hp <= 0


init : Class -> Creature
init class =
    { class = class
    , ap = 3
    , hp = 200
    }
