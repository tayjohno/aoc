module Day04 exposing (partOne, partTwo)

import Answer exposing (Answer(..))
import Array exposing (Array)
import Day04.Input exposing (Action(..), Date, Event, Guard, input)
import Dict exposing (Dict)
import Set exposing (Set)


type Status
    = Awake
    | Asleep


type alias SleepLogEntry =
    { guard : Guard, hourlyStatus : Array Status }


type alias SleepLog =
    List SleepLogEntry


partOne : () -> Answer String
partOne =
    \_ ->
        let
            guard =
                laziestElf

            hour =
                Tuple.first (sleepiestHour guard)
        in
        guard
            * hour
            |> String.fromInt
            |> Solved


partTwo : () -> Answer String
partTwo =
    \_ ->
        allGuards
            |> List.map (\g -> ( g, sleepiestHour g ))
            |> List.sortBy (\data -> -(data |> Tuple.second |> Tuple.second))
            |> List.head
            |> Maybe.withDefault ( 0, ( 0, 0 ) )
            |> (\( g, ( h, c ) ) -> g * h)
            |> String.fromInt
            |> Solved


buildSleepLog : List Event -> SleepLog
buildSleepLog eventList =
    case eventList of
        event :: list ->
            case event.action of
                StartShift guard ->
                    let
                        ( thisShift, futureEvents ) =
                            eventsThisShift [] list
                    in
                    buildSleepLogEntry thisShift guard :: buildSleepLog futureEvents

                _ ->
                    buildSleepLog list

        [] ->
            []


eventsThisShift : List Event -> List Event -> ( List Event, List Event )
eventsThisShift thisShift futureShift =
    case futureShift of
        [] ->
            ( thisShift, futureShift )

        event :: rest ->
            case event.action of
                StartShift guard ->
                    ( List.reverse thisShift, futureShift )

                _ ->
                    eventsThisShift (event :: thisShift) rest


buildSleepLogEntry : List Event -> Guard -> SleepLogEntry
buildSleepLogEntry eventList guard =
    buildSleepLogEntryHelper
        { guard = guard, hourlyStatus = Array.repeat 60 Awake }
        eventList


buildSleepLogEntryHelper : SleepLogEntry -> List Event -> SleepLogEntry
buildSleepLogEntryHelper sleepLogEntry eventList =
    case eventList of
        asleepEvent :: awakeEvent :: remainder ->
            case ( asleepEvent.action, awakeEvent.action ) of
                ( FallAsleep, WakeUp ) ->
                    let
                        sleepHours =
                            List.range asleepEvent.date.minute (awakeEvent.date.minute - 1)
                    in
                    buildSleepLogEntryHelper
                        { guard = sleepLogEntry.guard
                        , hourlyStatus =
                            Array.indexedMap
                                (\int status ->
                                    if List.any ((==) int) sleepHours then
                                        Asleep

                                    else
                                        status
                                )
                                sleepLogEntry.hourlyStatus
                        }
                        remainder

                _ ->
                    buildSleepLogEntryHelper sleepLogEntry (awakeEvent :: remainder)

        _ ->
            sleepLogEntry


countWhere : (a -> Bool) -> Array a -> Int
countWhere method array =
    Array.filter method array
        |> Array.length


laziestElf : Guard
laziestElf =
    buildSleepLog input
        |> List.map (\log -> ( log.guard, countWhere (\entry -> entry == Asleep) log.hourlyStatus ))
        |> List.foldl
            (\( guard, count ) dict ->
                Dict.update guard (\c -> Just (count + Maybe.withDefault 0 c)) dict
            )
            Dict.empty
        |> Dict.toList
        |> List.sortBy (\( _, a ) -> -a)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )
        |> Tuple.first


sleepiestHour : Guard -> ( Int, Int )
sleepiestHour guard =
    buildSleepLog input
        |> List.filter (\entry -> entry.guard == guard)
        |> List.map (\entry -> entry.hourlyStatus)
        |> List.map
            (\array ->
                Array.map
                    (\status ->
                        if status == Asleep then
                            1

                        else
                            0
                    )
                    array
            )
        |> List.foldl addArrays (Array.repeat 60 0)
        |> indexOfLargest


addArrays : Array Int -> Array Int -> Array Int
addArrays a1 a2 =
    addLists (Array.toList a1) (Array.toList a2)
        |> Array.fromList


addLists : List Int -> List Int -> List Int
addLists l1 l2 =
    case ( l1, l2 ) of
        ( head1 :: tail1, head2 :: tail2 ) ->
            head1 + head2 :: addLists tail1 tail2

        _ ->
            []


indexOfLargest : Array Int -> ( Int, Int )
indexOfLargest array =
    array
        |> Array.toIndexedList
        |> biggestMinute


biggestMinute : List ( Int, Int ) -> ( Int, Int )
biggestMinute list =
    list
        |> List.sortBy (\( _, a ) -> -a)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )


allGuards : List Int
allGuards =
    buildSleepLog input
        |> List.map (\entry -> entry.guard)
        |> Set.fromList
        |> Set.toList
