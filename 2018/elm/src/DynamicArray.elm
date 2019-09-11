module DynamicArray exposing (..)

import Array exposing (Array)


{-| A DynamicArray is useful for efficiently storing large sets of data without having to keep
reallocating memory.
-}
type alias DynamicArray a =
    { data : Array a
    , length : Int -- The number of items that have been inserted into this array.
    , default : a
    }


length : DynamicArray a -> Int
length dynamicArray =
    dynamicArray.length


new : a -> List a -> DynamicArray a
new default aList =
    { data = aList |> Array.fromList
    , length = aList |> List.length
    , default = default
    }


get : Int -> DynamicArray a -> Maybe a
get int { data } =
    Array.get int data


set : Int -> a -> DynamicArray a -> DynamicArray a
set int a dynamicArray =
    if int < Array.length dynamicArray.data then
        { dynamicArray
            | data = Array.set int a dynamicArray.data
            , length = max dynamicArray.length (int + 1)
        }

    else
        set int a (double dynamicArray)


max : Int -> Int -> Int
max int int2 =
    if int > int2 then
        int

    else
        int2


right : Int -> DynamicArray a -> List a
right int aDynamicArray =
    let
        array =
            aDynamicArray.data
    in
    Array.slice (aDynamicArray.length - int |> max 0) aDynamicArray.length array
        |> Array.toList


slice : Int -> Int -> DynamicArray a -> List a
slice int int2 aDynamicArray =
    Array.slice int int2 aDynamicArray.data
        |> Array.toList


insert : a -> DynamicArray a -> DynamicArray a
insert a aDynamicArray =
    set aDynamicArray.length a aDynamicArray


insertEach : List a -> DynamicArray a -> DynamicArray a
insertEach aList aDynamicArray =
    case aList of
        [] ->
            aDynamicArray

        item :: remaining ->
            insertEach remaining (insert item aDynamicArray)


toList : DynamicArray a -> List a
toList =
    .data >> Array.toList


{-| Doubles the length of the dynamic array. Only works with arrays with length > 0
-}
double : DynamicArray a -> DynamicArray a
double aDynamicArray =
    { aDynamicArray
        | data =
            Array.repeat aDynamicArray.length aDynamicArray.default
                |> Array.append aDynamicArray.data
    }
