module Day15.Creature exposing (Class(..), Creature, CreatureCoordinate, init, isDead)

import Coordinate exposing (Coordinate)
import Matrix
import Random


type alias Creature =
    { class : Class
    , ap : Int
    , hp : Int
    , startingCoordinate : Coordinate
    }


type alias CreatureCoordinate =
    ( Creature, Coordinate )


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
    , startingCoordinate = ( 0, 0 )
    }
