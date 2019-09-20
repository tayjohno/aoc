module Day16.Model exposing (..)

import Bitwise exposing (..)


type alias Instruction =
    { opCode : Int
    , arguments : ( Int, Int, Int )
    }


type alias Registers =
    { a : Int
    , b : Int
    , c : Int
    , d : Int
    }


type alias CPUSample =
    { startingState : Registers
    , instruction : Instruction
    , endingState : Registers
    }


type alias OpDefinition =
    { name : String
    , code : Maybe Int
    , op : Registers -> ( Int, Int, Int ) -> Result String Registers
    }


allOps : List OpDefinition
allOps =
    [ { name = "addr", op = addr, code = Just 1 }
    , { name = "addi", op = addi, code = Just 13 }
    , { name = "mulr", op = mulr, code = Just 15 }
    , { name = "muli", op = muli, code = Just 14 }
    , { name = "banr", op = banr, code = Just 0 }
    , { name = "bani", op = bani, code = Just 9 }
    , { name = "borr", op = borr, code = Just 8 }
    , { name = "bori", op = bori, code = Just 5 }
    , { name = "setr", op = setr, code = Just 3 }
    , { name = "seti", op = seti, code = Just 7 }
    , { name = "gtir", op = gtir, code = Just 6 }
    , { name = "gtri", op = gtri, code = Just 12 }
    , { name = "gtrr", op = gtrr, code = Just 4 }
    , { name = "eqir", op = eqir, code = Just 10 }
    , { name = "eqri", op = eqri, code = Just 2 }
    , { name = "eqrr", op = eqrr, code = Just 11 }
    ]


exampleCPUSample : CPUSample
exampleCPUSample =
    { startingState = { a = 4, b = 5, c = 6, d = 7 }
    , instruction = { opCode = 9, arguments = ( 1, 2, 3 ) }
    , endingState = { a = 3, b = 2, c = 2, d = 1 }
    }


setRegister : Int -> Registers -> Int -> Result String Registers
setRegister a registers val =
    case a of
        0 ->
            Ok { registers | a = val }

        1 ->
            Ok { registers | b = val }

        2 ->
            Ok { registers | c = val }

        3 ->
            Ok { registers | d = val }

        _ ->
            Err "Trying to set register: Out of bounds"


getRegister : Int -> Registers -> Result String Int
getRegister int registers =
    case int of
        0 ->
            Ok registers.a

        1 ->
            Ok registers.b

        2 ->
            Ok registers.c

        3 ->
            Ok registers.d

        _ ->
            Err "Trying to get register: Register out of bounds"


boolToInt : Bool -> Int
boolToInt bool =
    if bool then
        1

    else
        0


{-| addr (add register) stores into register C the result of adding register A and register B.
-}
addr : Registers -> ( Int, Int, Int ) -> Result String Registers
addr registers ( argA, argB, argC ) =
    Result.map2 (+) (getRegister argA registers) (getRegister argB registers)
        |> Result.andThen (setRegister argC registers)


{-| addi (add immediate) stores into register C the result of adding register A and value B.
-}
addi : Registers -> ( Int, Int, Int ) -> Result String Registers
addi registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.andThen ((+) argB >> setRegister argC registers)


{-| mulr (multiply register) stores into register C the result of multiplying register A and register B.
-}
mulr : Registers -> ( Int, Int, Int ) -> Result String Registers
mulr registers ( argA, argB, argC ) =
    Result.map2 (*) (getRegister argA registers) (getRegister argB registers)
        |> Result.andThen (setRegister argC registers)


{-| muli (multiply immediate) stores into register C the result of multiplying register A and value B.
-}
muli : Registers -> ( Int, Int, Int ) -> Result String Registers
muli registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.andThen ((*) argB >> setRegister argC registers)


{-| banr (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
-}
banr : Registers -> ( Int, Int, Int ) -> Result String Registers
banr registers ( argA, argB, argC ) =
    Result.map2 and (getRegister argA registers) (getRegister argB registers)
        |> Result.andThen (setRegister argC registers)


{-| bani (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
-}
bani : Registers -> ( Int, Int, Int ) -> Result String Registers
bani registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.andThen (and argB >> setRegister argC registers)


{-| borr (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
-}
borr : Registers -> ( Int, Int, Int ) -> Result String Registers
borr registers ( argA, argB, argC ) =
    Result.map2 or (getRegister argA registers) (getRegister argB registers)
        |> Result.andThen (setRegister argC registers)


{-| bori (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
-}
bori : Registers -> ( Int, Int, Int ) -> Result String Registers
bori registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.map (or argB)
        |> Result.andThen (setRegister argC registers)


{-| setr (set register) copies the contents of register A into register C. (Input B is ignored.)
-}
setr : Registers -> ( Int, Int, Int ) -> Result String Registers
setr registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.andThen (setRegister argC registers)


{-| seti (set immediate) stores value A into register C. (Input B is ignored.)
-}
seti : Registers -> ( Int, Int, Int ) -> Result String Registers
seti registers ( argA, argB, argC ) =
    argA
        |> setRegister argC registers


{-| gtir (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
-}
gtir : Registers -> ( Int, Int, Int ) -> Result String Registers
gtir registers ( argA, argB, argC ) =
    getRegister argB registers
        |> Result.map ((>) argA >> boolToInt)
        |> Result.andThen (setRegister argC registers)


{-| gtri (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
-}
gtri : Registers -> ( Int, Int, Int ) -> Result String Registers
gtri registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.map ((<) argB >> boolToInt)
        |> Result.andThen (setRegister argC registers)


{-| gtrr (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
-}
gtrr : Registers -> ( Int, Int, Int ) -> Result String Registers
gtrr registers ( argA, argB, argC ) =
    Result.map2 (>) (getRegister argA registers) (getRegister argB registers)
        |> Result.map boolToInt
        |> Result.andThen (setRegister argC registers)


{-| eqir (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
-}
eqir : Registers -> ( Int, Int, Int ) -> Result String Registers
eqir registers ( argA, argB, argC ) =
    getRegister argB registers
        |> Result.map ((==) argA)
        |> Result.map boolToInt
        |> Result.andThen (setRegister argC registers)


{-| eqri (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
-}
eqri : Registers -> ( Int, Int, Int ) -> Result String Registers
eqri registers ( argA, argB, argC ) =
    getRegister argA registers
        |> Result.map ((==) argB)
        |> Result.map boolToInt
        |> Result.andThen (setRegister argC registers)


{-| eqrr (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
-}
eqrr : Registers -> ( Int, Int, Int ) -> Result String Registers
eqrr registers ( argA, argB, argC ) =
    Result.map2 (==) (getRegister argA registers) (getRegister argB registers)
        |> Result.map boolToInt
        |> Result.andThen (setRegister argC registers)
