module Day13.Input exposing (..)

import Matrix exposing (Matrix)
import Parser exposing (..)


type alias Map =
    { tiles : Matrix Tile
    , carts : List Cart
    }


type Tile
    = Empty
    | LeftToRight
    | TopToBottom
    | TopToRight
    | TopToLeft
    | BottomToLeft
    | BottomToRight
    | Intersection


type alias Cart =
    { coordinate : Matrix.Coordinate
    , heading : Heading
    }


type Heading
    = North
    | South
    | East
    | West


rawInput : String
rawInput =
    """/->-╲
|   |  /----╲
| /-+--+-╲  |
| | |  | v  |
╲-+-/  ╲-+--/
  ╲------/"""



-- input : Map
-- input =
--   let
--     rows =
--       rawInput. split
--   in
--     { tiles = Matrix.fromRows rows, carts = [] }
--
-- ( aListList |> List.map List.length |> List.maximum |> Maybe.withDefault 0
-- , aListList |> List.length
-- )
-- prettyPrintMap : String


prettyPrintRawString : String -> Maybe a
prettyPrintRawString string =
    rawInput
        |> String.split "\n"
        |> List.reverse
        |> List.map (\a -> Debug.log "" a)
        |> always Nothing


prettyPrintMap : Matrix Tile -> Maybe a
prettyPrintMap matrix =
    matrix
        |> Matrix.toRows
        |> prettyPrintMapList
        |> always Nothing


prettyPrintMapList : List (List Tile) -> Maybe a
prettyPrintMapList list =
    list
        |> List.map
            (List.map tileToS
                >> String.join ""
            )
        |> List.reverse
        |> List.map (\a -> Debug.log "" a)
        |> always Nothing


tileParser : Parser ( List Tile, List Cart )
tileParser =
    oneOf
        [ succeed ( [ LeftToRight, BottomToLeft ], [] ) |. token "-╲"
        , succeed ( [ LeftToRight, TopToLeft ], [] ) |. token "-/"
        , succeed ( [ Empty ], [] ) |. token " "
        , succeed ( [ LeftToRight ], [] ) |. token "-"
        , succeed ( [ LeftToRight ], [ { coordinate = ( 0, 0 ), heading = West } ] ) |. token "<"
        , succeed ( [ LeftToRight ], [ { coordinate = ( 0, 0 ), heading = East } ] ) |. token ">"
        , succeed ( [ TopToBottom ], [] ) |. token "|"
        , succeed ( [ TopToBottom ], [ { coordinate = ( 0, 0 ), heading = North } ] ) |. token "^"
        , succeed ( [ TopToBottom ], [ { coordinate = ( 0, 0 ), heading = South } ] ) |. token "v"
        , succeed ( [ BottomToRight ], [] ) |. token "/"
        , succeed ( [ TopToRight ], [] ) |. token "╲"
        , succeed ( [ Intersection ], [] ) |. token "+"
        ]


topToBottomToken : Parser ()
topToBottomToken =
    oneOf
        [ token "|"
        , token "v"
        , token "^"
        ]


tileToS : Tile -> String
tileToS tile =
    case tile of
        Empty ->
            " "

        LeftToRight ->
            "-"

        TopToBottom ->
            "|"

        TopToRight ->
            "╲"

        TopToLeft ->
            "/"

        BottomToLeft ->
            "╲"

        BottomToRight ->
            "/"

        Intersection ->
            "+"


mapParser : Parser ( List (List Tile), List Cart )
mapParser =
    succeed identity
        |= Parser.loop ( [], [] ) mapHelper
        |. end


mapHelper : ( List (List Tile), List Cart ) -> Parser (Step ( List (List Tile), List Cart ) ( List (List Tile), List Cart ))
mapHelper ( mapMemo, cartMemo ) =
    let
        _ =
            Debug.log "memo" mapMemo
    in
    oneOf
        [ succeed ()
            |. end
            |> map (\_ -> Done ( List.reverse mapMemo, cartMemo ))
        , succeed (\( newTiles, newCarts ) -> Loop ( newTiles :: mapMemo, List.append newCarts cartMemo ))
            |= rowParser
        , succeed ()
            |> map (\_ -> Done ( List.reverse mapMemo, cartMemo ))
        ]


rowParser : Parser ( List Tile, List Cart )
rowParser =
    succeed identity
        |= Parser.loop ( [], [] ) rowHelper
        |. oneOf
            [ succeed () |. token "\n"
            , succeed ()
            ]


rowHelper : ( List Tile, List Cart ) -> Parser (Step ( List Tile, List Cart ) ( List Tile, List Cart ))
rowHelper ( rowMemo, cartMemo ) =
    oneOf
        [ succeed (\( r, c ) -> Loop ( List.append rowMemo r, List.append cartMemo c ))
            |= tileParser
        , succeed ()
            |> map (\_ -> Done ( rowMemo, cartMemo ))
        ]


input : Map
input =
    let
        parsedMap =
            run mapParser rawInput
    in
    case parsedMap of
        Result.Err _ ->
            Debug.todo "Couldn't parse a map"

        Result.Ok ( rows, carts ) ->
            { carts = carts, tiles = Matrix.fromRows rows Empty }



{--
    """                /-->------------------------------╲  /-----------------------------------------------------------╲
                |      /--------------------------+--+------------------------------------╲                      |                /------------------╲
                |      |                          |  |      /-----------------------------+----------------------+----------╲     |                  |
                |      |                          |  |      |                             |                      |          |     |                  |
               /+------+--------------------------+--+------+-----------------------------+----------╲           |          |     |                  |
               ||      |  /-----------------------+--+------+-----------------------------+----------+-----------+----------+-----+--╲               |
/--------------++------+--+--------------------╲  |  |  /---+-----------------------------+----------+-----------+----------+-----+-╲|               |
|  /-----------++------+--+--------------------+--+--+--+---+-----------------------------+---╲      |        /--+-------╲  |     | ||               |
|  |           ||      |  |                    |  |  |  |   |                             |   | /----+--------+--+-------+╲ |     | ||               |
|  |           ||      |  |     /--------------+--+--+--+---+------------------╲          |   | |    |        |  |       || |     | ||               |
|  |           ||      |  |     |              |  |  |  |   |    /-------------+----------+---+-+----+--------+-╲|       || |     | ||               |
|  |           ||      |  | /---+--------------+--+--+--+---+----+----╲        |          |   | |    |        | ||       || |     | ||               |
|  |           ||      |  | |   |              |  |  |  |   |    |    |     /--+----------+---+-+----+--------+-++-------++-+-----+-++--------╲      |
|  |           ||      |  | |   |          /---+--+--+--+---+----+--╲ |     |  |          |   | |/---+--------+-++--╲    || |     | ||        |      |
|  |           ||      ╲--+-+---+----------+---+--+--+--+---+----+--+-+-----+--+----------/   | ||   |        | ||  |    || |     | ||        |      |
|  |           ||         ╲-+---+----------+---+--+--+--+---+----+--+-+-----+--+--------------+-++---+--------+-++--+----++-+-----+-+/        |      |
|  |           ||  /--------+---+----╲     |   |  |  |  |   |    |  v |     |  |/-------------+-++---+-----╲  | ||  |    || |     | |         |      |
|  |           ||  |        |   |   /+-----+---+--+--+--+-╲ |    |  | |     |  ||             | ||   |     |  | ||  |    || |     | |         |      |
|  |           ||  |       /+---+---++-----+---+--+--+--+-+-+----+--+-+-----+--++-------------+-++---+-----+--+-++--+----++-+-----+╲|         |      |
|  |           ||  |       ||   |   ||     | /-+--+--+--+-+-+----+-╲|/+-----+--++-------------+-++---+---╲ |  | ||  |    || |     |||         |      |
|  |          /++--+-------++---+-╲ ||     | | |  |  |  | | |    | ||||     |  ||             | ||   |   | |  | ||  |    || |  /--+++---------+-----╲|
|/-+----------+++--+-------++---+╲| ||     | | |  |  |  | | |    | ||||     |  ||             | ||   |   | |  | ||  |    || |  |  |||         |     ||
|| |          |||  |       ||   ||| ||     | | |  |  |  | |/+----+-++++-----+--++-------------+-++---+---+-+--+-++--+----++-+--+--+++----╲    |     ||
|| |      /---+++--+-------++---+++-++╲    | | |  |  |  | |||    | ||||     |  ||             | ||   |   | |  | ||  |    || |  |  |||    |    |     ||
|| |      |/--+++--+-╲     ||   ||| |||    | | |  |  |  | |||    | ||||     |  ||             | ||   |   | |  | ||  |    || |  |  |||    |    |     ||
|| |      ||  |||  | |     ||   ||| |||/---+-+-+--+--+--+-+++----+-++++-----+--++-----╲       | ||   |   | |  | ||  |    || |  |  |||    |    |     ||
|| |      ||  |||  | |     ||   ╲++-++++---+-+-+--+--+--+-+++----+-++++-----+--/|     |       | ||   |   | |  | ||  |    || |  |  |||    |    |     ||
|| |      ||  |╲+--+-+-----++----++-++++---+-+-+--+--+--+-+++----+-++++-----+---+-----+-------+-++---/   | |  ╲-++--+----/| |  |  |||    |    |     ||
|| |      ||  | |  | |  /--++----++-++++---+-+╲|  ^  | /+-+++----+-++++-----+---+-----+-------+-++-------+-+----++--+-----+-+--+--+++--╲ |    |     ||
|| ╲------++--+-+--+-+--+--++----++-++++---+-+++--+--+-++-+++----+-++++-----+---+-----+-------/ ||       | |    ||  |     | |  |  |||  | |    |     ||
||        ||  | |  | |  |  ╲+----++-++++---+-+++--+--+-++-+++----+-++++-----+---+-----+---------++-------+-+----++--+-----+-+--+--+/|  | |    |     ||
||        ||  | |  | |  |   |    || |||| /-+-+++--+--+-++-+++----+-++++-----+---+-----+---------++-------+-+----++--+-----+-+--+-╲| |  | |    |     ||
||        ||  | |  | |  |   |    || |||| | | |||  |  | || |||   /+-++++-----+---+-----+---------++-------+-+----++--+-----+-+--+-++-+--+-+--╲ |     ||
||  /-----++--+-+╲ | |  |   |    || |||| | | |||  | /+-++-+++---++-++++-----+---+-----+---------++-------+-+----++--+-----+-+--+-++-+╲ | |  | |     ||
||  |     ||  | || | |  |   |    || |||| | | |||  | |╲-++-+++---++-++++-----+---+-----+---------++-------+-+----+/  |     | |  | || || | |  | |     ||
||  |     ||  | || | | /+---+----++-++++-+-+-+++--+-+--++-+++---++-++++-----+---+-----+--╲      ||       | |    |   |     | |  | |╲-++-+-+--+-+-----+/
||  |/----++--+-++-+-+-++---+----++-++++-+-+-+++--+-+--++-+++---++-++++-----+---+-----+-╲|      ||       | |    |   |     | |  | |  || | |  | |     |
||  ||    ||  | || | | ||   |    || |||| | | |||  | |  || |||   || ||||/----+---+-╲   | ||      ||/------+-+----+---+-----+-+--+-+--++-+-+--+-+-╲   |
||  ||    ||  | || | | ||   |    || |||| | | ╲++--+-+--++-+++---++-/||||    |  /+-+---+-++------+++------+-+----+---+-----+-+--+-+╲ || | |  | | |   |
||  ||    || /+-++-+-+-++---+--╲ || |||| | |  ||  | |  || |||   ||  ||||    |  ||/+---+-++-╲    |||/-----+-+----+---+-----+-+--+╲|| || | |  | | |   |
||  ||    || || || ╲-+-++---+--+-++-+/||/+-+--++--+-+--++-+++---++--++++----+--++++---+-++-+----++++-----+-+--╲ |   |     | |  |||| || | |  | | |   |
||  ||    || || ||   | ||  /+--+-++-+-++++╲|  ||  | |  || |||   ||  ||||    |  ||||   | || |    ||||     | |  | |   |     | |  ╲+++-++-+-+--+-+-+---/
||  ||    || || ||   | ||  |╲--+-++-+-++++++--++--+-+--++-+++---++--++/|    |  ||||   | || |    ||||     | |  | |   |     | |   ||| || | |  | | |
||  ||    || || ||/--+-++--+---+-++-+-++++++--++--+-+--++-+++---++--++-+----+--++++---+-++-+----++++-----+-+--+-+-╲ |     |/+---+++-++-+-+--+-+-+---╲
||/-++----++-++-+++--+-++--+---+-++-+-++++++--++--+-+--++-+++---++--++-+----+--++++---+-++-+----++++---╲ | |  | | | |     |||   ||| || | |  | | |   |
||| ||    || || |||  | ||  |   | || | ||||||  ||  | ╲--++-+++---++--++-+----+--++++---+-++-+----++++---+-+-+--+-+-+-+-----+++---+++-+/ | |  | | |   |
||| ||    || || |||  | ||  |   | ||/+-++++++--++--+----++-+++---++--++-+----+--++++---+-++-+----++++---+-+-+╲ | | | |     |||   ||| |  | |  | | |   |
||| ||    || || |||  | ||  |   | |||| ||||||/-++--+----++-+++---++--++-+----+--++++---+-++-+----++++---+-+-++-+-+-+-+-----+++---+++-+--+-+--+-+╲|   |
||| ||    || || |||  | ||  |   | |||| |╲+++++-++--+----++-+++---++--++-+----+--++++---/ || |    |||^   | | || | | | |     |||   ||| |  | |  | |||   |
|╲+-++----++-++-+++--+-++--+---+-/||| | ||||| ||  |    || |||   ||  || |/---+--++++-----++-+----++++---+-+-++-+-+-+-+-----+++---+++-+--+-+--+-+++-╲ |
| | ||    || || |||  | ||  |   |  ||| | ||||| ||  |    || |||   ||  || || /-+--++++-----++-+----++++---+-+-++-+-+-+-+--╲  |||   ||| |  | |  | ||| | |
| | ||   /++-++-+++--+-++--+---+--+++-+-+++++-++--+----++-+++---++--++-++-+-+--++++-----++-+----++++---+-+-++-+╲| | |  |  |||   ||| |  | |  | ||| | |
| | ||   ||| || |||  | ||  |   |  ||| | ||||| ||  |    || |||   ||  || || | |  ||||     || |    ||||   | | || ||| | |  |  |||   ||| |  | |  | ||| | |
| | ||   ||| || |||  | ||  |   |  ||| | ||||| ||  |    || |||   ||  || || | |  ||||     || |  /-++++---+-+-++-+++-+-+--+╲ |||   ||| |  | |  | ||| | |
| | ||   ||| || |||  | ||  |   |  ||| | ||||| ||  |    || |||   ||  || || | |/-++++-----++-+--+-++++╲  | | |v ||| | |  || |||   ||| |  | |  | ||| | |
| | ||   ||| || |||  | ||  |   |/-+++-+-+++++-++--+----++-+++---++--++╲|| | || ||||     || |  | |||||  | | || ||| | |  || |||   ||| |  | |  | ||| | |
| | ╲+---+++-++-+/|  | ||  ╲---++-+++-+-++/|| ||  |    ╲+-+++---++--+++++-+-++-++++-----++-+--+-+++++--+-+-++-+++-+-+--++-+++---+++-+--/ |  | ||| | |
| |  |   ||| || | |  | ||      || ||| | || || ||  |     |/+++---++--+++++-+-++╲||||     || |  | |||||  | | || ||| | |  || |||   ||| |    |  | ||| | |
| |  |   ||| || | |  | ||      || ||| | || || || /+-----+++++---++--+++++-+-+++++++-----++-+--+-+++++--+-+-++-+++-+-+--++-+++---+++-+----+╲ | ||| | |
| |  |   ||| || | v  | ||      || ||| | || || || ||     |||||   ||  ||||| | ╲++++++-----++-+--+-+++++--+-+-++-+++-+-+--++-+++---+++-+----++-+-/|| | |
| |  |   ||| || | |  | ||      || ||| | || |╲-++-++-----+++++---++--+++++-+--++++++-----++-+--+-+++++--+-+-++-+++-+-+--++-+++---+++-+----++-+--/| | |
| |  |   ||| || | |  | ||      || ||| | || |  || ||     |||||   ||  ||||| |  ||||||     || |  | |||||  | | || ||| | |  || |||   ||| |    || |   | | |
| |  |   ||| || | |  | ||      || ||| | || |  || ||     |||||   |╲--+++++-+--++++++-----++-+--+-+++++--+-+-++-++/ | |  || |||   ||| |    || |   | | |
| |  |   ||| || | |  | ||      || ||| | || |  || ||     |||||   |   ||||| |  ||||||     || |  |/+++++--+╲| || ||  | |  || |||   ||| |    || |   | | |
| |  |   ||| || | |  | ||      || ||| | || |  || ||     |||||   |   ||||| |/-++++++-----++-+--+++++++--+++-++-++--+-+--++-+++---+++-+╲   || |   | | |
| |  |   ||| || | |  | ||      || ||| | || |  || ||     |||^|   |   ||||| || ||||||     || |  |||╲+++--+++-++-++--+-/  || |||   ||| ||   || |   | | |
| |  |/--+++-++-+-+--+-++------++-+++-+-++-+--++-++-----+++++---+---+++++-++╲||||||     || |  ||| |||  ||| || ||  |    || |||   ||| ||   || |   | | |
| ╲--++--+++-++-+-+--+-++------++-+++-+-++-+--++-++-----+++++---+---+++++-+++++++++-----++-+--+++-+++--/|| || ||  |    || |||   ||| ||   || |   | | |
|    ||  ||| || | |  | ||      || ||| | || |  || ||/----+++++---+---+++++-+++++++++-----++-+--+++-+++---++-++-++-╲|    || |╲+---+++-++---++-+---+-+-/
|    ||  ||| || | |  | ||      || ||| | || |  || |||    |||||   |   ||||| |||||||||     || |/-+++-+++---++-++-++-++----++-+-+---+++-++╲/-++-+---+-+-╲
|    ||  ||| || | |  | ||      || ||| | || |  || |||    |||||   |   ||||| ||||||||| /---++-++-+++╲|||   || || || ||    || | |   ||| |||| || |   | | |
|    ||  ||| || | |  | ||      || |||/+-++-+--++-+++----+++++---+---+++++-+++++++++-+---++-++-+++++++---++-++-++╲||    || | | /-+++-++++-++-+╲  | | |
|    ||  ||| || | |  |/++------++-+++++-++-+--++╲|||    |||||   |   ||||| ||||||||| |   || || |||||||   || || |||||    || | | | ||| |||| || ||  | | |
|/---++--+++-++-+-+╲ ||||   /--++-+++++-++-+--++++++----+++++--╲|   ^|||| |||╲+++++-+---++-++-++++++/   || || |||||    || | | | ||| |||| || ||  | | |
||   ||  ||| || | || ||||   |  || ||||| || |  ||||||    |||||  ||   ||||╲-+++-+++++-+---++-++-++++++----++-++-+++++----++-+-+-+-+++-++++-++-++--+-/ |
||   ||  ||| || | || ||||   |  || ||||| || |  ||||||    |||||  ||/--++++--+++-+++++-+---++-++-++++++----++-++-+++++----++-+-+-+-+++-++++-++-++--+---+╲
||   ||  ||| || | || ||||   |  || ||||| || |  ||||||    |||||  |||  ||||  ||| ||||| |/--++-++-++++++----++-++-+++++----++-+-+-+-+++-++++-++-++-╲|   ||
||/--++--+++-++-+╲|| ||||   |  || ||||| || |  ||||||    |||||  |||  ||||  ||| ||||| ||  || || ||||||    || || |||||    || | | | ||| |||| || || ||   ||
|||  ||  ||| || |||| ||||/--+--++-+++++-++-+--++++++----+++++--+++--++++--+++-+++++-++╲ || || ||||||    || || |||||    || | | | ||| |||| || || ||   ||
|||  ||  ||| || |||| |||||  |  || ||||| || |  ||||||    |||||  |||  ||||  ||| ||||| ||| || || ||╲+++----++-++-+++++----++-/ | | ||| |||| || || ||   ||
|||  ||  ||| || |||| |||||  |  || ||||| || |  ||||||    |||||  |||  ||||  ||| ||||| ||| || || || |||    || || |||||    ||   | | ||| |||| || || ||   ||
|||/-++--+++-++-++++-+++++--+--++-+++++-++-+--++++++--╲ |||||  |||  ||||  ||| ||||| ||| || || || |||    || || |||||    ||   | | ||| |||| || || ||   ||
|||| ||  ||| || ╲+++-+++++--+--++-+++++-++-+--++++/|  | |||||  |||  ||||  ||| ||||| ||| || || || |||    || || |||||    ||   | | ||| |||| || || ||   ||
|||| ||  ||╲-++--+++-/||||  |  || ||||| || |  |||| |  | ||||| /+++--++++--+++-+++++-+++-++-++-++-+++----++-++-+++++----++---+-+-+++-++++-++-++╲||   ||
|||| ||  ||  ||  |||  ||||  |  || ||||| ||/+--++++-+--+-+++++-++++--++++--+++-+++++-+++-++-++-++-+++----++-++-+++++--╲ ||   | | ||| |||| || |||||   ||
||v| ||  ||  ||  |||  ||||  |  || ||||| ||||  |||| |  | ||||| ||||  ||||  ||| ||||| ||| ||/++-++-+++----++-++-+++++╲ | ||   | | ||| |||| || |||||   ||
|||| ||  ||  ||  |||  ||||  |  || ||||| ||||  |||| |  | ╲++++-++++--++++--+++-+++++-+++-+++++-++-+++----++-++-++++++-+-++---+-+-+++-/||| || |||||   ||
|||| ||  ||  ||  |||  ||||  ╲--++-+++++-++++--++++-+--+--++++-+/||  |╲++--+++-+++++-+++-+++++-++-+++----+/ || |||||| | ||   | | |||  ||| || |||||   ||
|||| ||  ||  ||  |||  ||||     || ||||| ||||  |||| |  |  |||| | ||  | ||  ||| ||||| ||| ||||| || |||    |  || |||||| | ||   | | |||  ||| || |||||   ||
╲+++-++--++--++--+++--++++-----++-+++++-++++--+/|| | /+--++++-+-++╲ | ||  ||| ||||| ||| ||||| || |||    |  || |||||| | ||   | | |||  ||| || |||||   ||
 ||| ||  ||  ||  |||  ||||     || ||╲++-++++--+-++-+-++--+/|| | ||| | ||  ||| ||||| ||| ||||| || |||    |  || |||||| | ||   | | |||  ||| || |||||   ||
 ||╲-++--++--++--+++--++++-----++-++-++-++++--+-++-+-+/  | || | ||| | ||  |╲+-+++++-+++-+++++-++-+++----+--++-++++++-+-++---+-+-+++--/|| || |||||   ||
 ||  ||  ||  ||  |||  ||||     || || || ||||  | || | |   | || | ╲++-+-++--+-+-+++++-+++-+++++-++-+++----+--++-++++++-+-++---+-+-+++---++-++-/||||   ||
 ||  ||  ||  ||  |||  ||╲+-----++-++-++-++++--/ || | |   | || |  || | ||  | ^ ||||| ||| ||||| || |||    |  || |||||| | ||   | | |||   || ||  ||||   ||
 ||  ||  ||  ||  |||  || |     || || || ||||    || | |   | || |  || | ||  | | ||||| ||| ||||| || |||    |  || |||||| | ||   | | |||   || ||  ||||   ||
 ||  ||  ||  ||/-+++--++-+-----++-++-++-++++----++-+-+---+-++-+--++-+-++--+-+-+++++-+++-+++++-++-+++---╲|  || |||||| | ||   | | |||   || ||  ||||   ||
 ^|  ||  ╲+--+++-+++--++-+-----++-++-++-++++----++-+-+---+-++-+--++-+-++--+-+-+++++-+++-+++++-++-+++---++--++-+/|||| | ||   | ╲-+++---++-++--/|||   ||
 ||  ||   |  ||| |||  ||/+-----++-++-++-++++----++-+-+---+-++-+--++-+-++╲ | | ||||| ||| ||||| || |||   ||  || | |||| | ||   |   |||   || ||   |||   ||
 ||  ||/--+--+++-+++--++++-----++-++-++-++++╲   || ╲-+---+-++-+--++-+-+++-+-+-+++++-+++-+++++-++-+++---++--++-+-+/|| | ||   |   |||   || ||   |||   ||
 ||  |||  |  ||| |||  ^|||     || || ||/+++++---++---+---+-++-+--++-+-+++-+-+-+++++-+++-+++++-++╲|||   ||  || | | || | ||   |   |||   || ||   |||   ||
 ||  |||  |  ||| |||  ||||     || || ||||||╲+---++---+---+-++-+--++-/ ||| | | ||||| ╲++-+++++-+++/||   ||  || | | || | ||/--+---+++---++-++--╲|||   ||
 ||  |||  |  ||| |||  ||||     || || |||||| |   ||   |   | |╲-+--++---+++-+-+-+++++--++-+++++-+++-++---++--++-+-+-++-+-+++--/   |||   || ||  ||||   ||
 ||  ╲++--+--+++-+++--++++-----++-++-++++++-+---++---+---+-+--+--++---+++-+-+-+++++--++-/|||| ||| |╲---++--++-+-+-++-+-+++------/||   || ||  ||||   ||
 ||   ||  |/-+++-+++--++++-----++-++-++++++-+---++---+---+-+--+--++---+++-+-+-+++++--++--++++-+++-+--╲ ||  || | | || | |||       ||   || ||  ||||   ||
 ||   ||  || ||| |||  ||||     || || |||||| |   ||   |   | |/-+--++---+++-+-+-+++++--++--++++-+++-+--+-++--++-+-+-++-+-+++------╲||   || ||  ||v|   ||
 ||   ||  || ||| |||  ||||     || || |||||| |   ||   |   | || |  ||   ||v | | ||╲++--++--++++-+++-+--+-++--/| | | || | |||      |||   || ||  ||||   ||
 ||   ||  || ||| |||  ||||/----++-++-++++++-+---++╲  |   | || |  ||   |||/+-+-++-++--++--++++-+++╲|  | ||  /+-+-+-++-+-+++-----╲|||   || ||  ||||   ||
 ||   ╲+--++-+++-+++--+++++----++-++-++++++-+---+++--+---+-++-+--++---+++++-/ |╲-++--++--++++-+++++--+-++--++-+-+-++-+-+++-----+++/   || ||  ||||   ||
 ||    |  || ||| |||  |||||    || || ||╲+++-+---+++--+---+-++-+--++---+++++---+--++--++--++++-++/||  | ||  || | | || | |||     |||    || ||  ||||   ||
 ||    |  || ||| |||  ╲++++----++-++-++-+++-+---/||  |   | || |  ||   |||||   |  ||  ╲+--++++-++-++--+-++--++-+-+-++-+-+++-----+++----++-++--++/|   ||
 ||    |  || ||| |||   ||||    || || || ╲++-+----++--+---+-++-+--++---+++++---+--++---+--++++-++-++--+-++--++-/ | || | |||     |||    || ||  || |   ||
 ||    |  || |╲+-+++---++++----++-/| ||  || |    ||  |   | || |  ||   |||||   |  ||   |  |||| || ||  | ||  ||   | || | |||     |||/---++-++--++-+--╲||
 ||    |  |╲-+-+-+++---++++----++--+-++--++-+----++--+---+-++-+--++---+++++---+--++---+--++++-++-++--/ ||  ||   | || | |||     ||||   || ||  || |  |||
 ||    | /+--+-+-+++-╲ ||||    ||  | ||  || |    ^|  |   ╲-++-+--++---+++++---/  ||   |  |||| ╲+-++----++--++<--+-++-+-+/|     ||||   || ||  || |  |||
/++----+-++--+-+-+++-+╲||||    ||  | ||  || |    ||  |     |╲-+--++---+++++------++---+--++++--+-++----++--++---+-++-+-+-+-----+/||   || ||  || |  |||
|||    | ||  | | ||| ||||||    ||  | ||  |╲-+----++--+-----+--+--++---+++++------++---+--++++--+-++----++--++---+-++-/ | |     | ||   || ||  || |  |||
|||    | ||  | | ||| ||||||    ||  | ||  |  |    ||/-+-----+--+--++---+++++------++---+--++++--+-++----++--++---+-++---+-+-----+-++---++-++-╲|| |  |||
|||    | ||  | | ||| ||||╲+----++--+-++--+--+----+++-+-----+--+--++---+++++------++---/  ||||  | ||    ||  ╲+---+-++---+-+-----/ ||   || || ||| |  |||
|||    | ||  | | ||| |||| |    ||  | ||  ╲--+----+++-+-----+--+--++---+++++------++------++++--+-++----++---+---+-++---+-+-------/|   || || ||| |  |||
|||    | ||  | | ||| |||| |    ||/-+-++-----+----+++-+-----+<-+╲ ||   |||||      ╲+------++/|  | |╲----++---+---+-++---+-+--------+---++-++-+++-/  |||
|||    | ||  | ╲-+++-++++-+----+++-+-++-----+----+++-+-----+--++-++---+++++-------+------++-+--+-+-----/|   |   | ||   | |        |   || || |||    |||
|||    | ||  |   ||| |||| |    ||| | ||     |    ||| |     |  || ||   |╲+++-------/      || |  | |      |   |   | ||   | |        |   || || |||    |||
|||    | ||  |   ||| |||| |    ||| | ||     |    ||| ╲-----+--++-+/   | |||              || |  | |      |   |   | ||   | |        |   || || |||    |||
|||    | ||  |   ||| |||| |    ||| | ||     |    |||       ╲--++-+----+-+++--------------++-+--+-+------+---+---+-++---+-+--------+---++-/| |||    |||
|||    | ||  | /-+++-++++-+----+++-+-++-----+----+++----------++-+----+-+++-----------╲  || |  | |      |   |   | ||   | |        |   ||  | |||    |||
|||    | |╲--+-+-+++-++++-+----+++-+-+/  /--+----+++----------++-+----+-+++-----------+--++-+--+-+╲     |   |   | ||   | |        |   ||  | |||    |||
|||    | |   | | ||| |||| |    ||| | |   |  |    |||          || |    | |||       /---+--++-+--+-++-----+---+---+╲||   | |        |   ||  | |||    |||
|||    | |   | | ||| |||| |    ||| ╲-+---+--+----+++----------++-+----+-+++-------+---+--++-+--+-++-----+---/   ||||   | ╲--------+---++--+-+/|    |||
|||    | |   | | ||| |||| |    |||   |   |  |    ||╲----------++-+----+-+++-------+---+--++-+--+-++-----+-------++++---+----------+---++--+-/ |    |||
|||    | |   | | ||| |||| |    |||   |   |  |    ||           || |    | |||       |   |  |╲-+--+-++-----+-------+++/   |          |   ||  |   |    |||
|||    | |   | | ||| |||| | /--+++---+---+--+----++-----------++-+----+-+++------╲|   |  |  |  | ||     |       |||    |          |   ||  |   |    |||
|||    | |   | | ||| |||| | |  |||   |   |  |    ||           || ╲----+-+++------++---+--+--+--+-++-----+-------+++----+----------+---++--+---+----++/
|||    | |   | | |╲+-++++-+-+--+++---+---+--+----++-----------++------+-+++------++---+--+--+--+-++-----+-------++/    |          |   ||  |   |    ||
|||    ╲-+---+-+-+-+-++++-+-+--+++---+---+--/    ||           ||      | |||      ||   |  |  |  | ||     |       ||     |  /-------+---++--+---+-╲  ||
|||      |   | | | | |||| | |  |||   |   |       ||           ||      | |||      ||   |  |  |  | ||     |       ||     |  |       |   ||  |   | |  ||
|||      |   ╲-+-+-+-++++-+-+--/||   |   |       ||           ||      | |||      |╲---+--+--+--+-++-----+-------+/     |  |       |   ||  |   | |  ||
|||      |     | | | |||| ╲-+---++---+---+-------+/           ||      | |||      |    |  |  |  | ||     |       |      |  |       |   ||  |   | |  ||
|||      |     | | | ||||   |   ||   |   |       |            ╲+------+-+++------+----+--+--+--+-++-----+-------+------+--+-------+---++--+---/ |  ||
╲++------+-----+-+-+-+/||   |   ||   |   |       ╲-------------+------+-+++------+----+--+--+--+-++-----+-------+------+--+-------+---++--/     |  ||
 |╲------+-----+-/ | | ||   |   ╲+---+---+---------------------+------/ |||      |    |  |  ╲--+-++-----+-------+------+--+-------+---/|        |  ||
 |       |     |   | | ||   |    ╲---+---+---------------------/        |||      |    |  |     | ||     |       |      |  |       |    |        |  ||
 |       |     |   | | |╲---+--------+---+------------------------------/╲+------+----+--+-----+-/|     |       |      |  |       |    |        |  ||
 |       ╲-----+---+-/ ╲----+--------+---+--------------------------------+------+----+--/     |  |     |       |      |  |       |    |        |  ||
 ╲-------------+---/        |        ╲---+--------------------------------+------+----+--------+--+-----+-------/      |  |       |    |        |  ||
               |            ╲------------+--------------------------------+------/    |        |  |     |              |  |       |    ╲--------+--+/
               |                         |                                ╲-----------+--------+--+-----+--------------/  |       |             |  |
               |                         |                                            |        |  |     |                 |       |             |  |
               |                         |                                            |        ╲--+-----/                 |       |             |  |
               ╲-------------------------+--------------------------------------------/           |                       |       ╲-------------+--/
                                         ╲--------------------------------------------------------/                       ╲---------------------/"""
--}
