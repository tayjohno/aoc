module Day07.Input exposing (input)

import Day07.DataTypes exposing (Prerequisite)
import Parser exposing ((|.), (|=), Parser, chompIf, keyword, mapChompedString, run, spaces, succeed)


input : List Prerequisite
input =
    String.split "\n" rawInput
        |> List.filterMap (\line -> run prerequisiteParser line |> Result.toMaybe)
        |> List.sortBy (\( _, a ) -> a)


prerequisiteParser : Parser Prerequisite
prerequisiteParser =
    succeed (\a b -> ( a, b ))
        |. keyword "Step"
        |. spaces
        |= charParser
        |. spaces
        |. keyword "must"
        |. spaces
        |. keyword "be"
        |. spaces
        |. keyword "finished"
        |. spaces
        |. keyword "before"
        |. spaces
        |. keyword "step"
        |. spaces
        |= charParser


charParser : Parser Char
charParser =
    mapChompedString (\a b -> a |> String.toList |> List.head |> Maybe.withDefault '?') <|
        succeed identity
            |. chompIf Char.isAlpha


rawInput =
    "Step G must be finished before step T can begin.\nStep L must be finished before step V can begin.\nStep D must be finished before step P can begin.\nStep J must be finished before step K can begin.\nStep N must be finished before step B can begin.\nStep K must be finished before step W can begin.\nStep T must be finished before step I can begin.\nStep F must be finished before step E can begin.\nStep P must be finished before step O can begin.\nStep X must be finished before step I can begin.\nStep M must be finished before step S can begin.\nStep Y must be finished before step O can begin.\nStep I must be finished before step Z can begin.\nStep V must be finished before step Z can begin.\nStep Q must be finished before step Z can begin.\nStep H must be finished before step C can begin.\nStep R must be finished before step Z can begin.\nStep U must be finished before step S can begin.\nStep E must be finished before step Z can begin.\nStep O must be finished before step W can begin.\nStep Z must be finished before step S can begin.\nStep S must be finished before step C can begin.\nStep W must be finished before step B can begin.\nStep A must be finished before step B can begin.\nStep C must be finished before step B can begin.\nStep L must be finished before step P can begin.\nStep J must be finished before step V can begin.\nStep E must be finished before step W can begin.\nStep Z must be finished before step W can begin.\nStep W must be finished before step C can begin.\nStep S must be finished before step W can begin.\nStep Q must be finished before step S can begin.\nStep O must be finished before step B can begin.\nStep R must be finished before step W can begin.\nStep D must be finished before step H can begin.\nStep E must be finished before step O can begin.\nStep Y must be finished before step H can begin.\nStep V must be finished before step O can begin.\nStep O must be finished before step S can begin.\nStep X must be finished before step V can begin.\nStep R must be finished before step E can begin.\nStep S must be finished before step A can begin.\nStep K must be finished before step Y can begin.\nStep V must be finished before step W can begin.\nStep U must be finished before step W can begin.\nStep H must be finished before step R can begin.\nStep P must be finished before step I can begin.\nStep E must be finished before step C can begin.\nStep H must be finished before step Z can begin.\nStep N must be finished before step V can begin.\nStep N must be finished before step W can begin.\nStep A must be finished before step C can begin.\nStep V must be finished before step E can begin.\nStep N must be finished before step Q can begin.\nStep Y must be finished before step V can begin.\nStep R must be finished before step O can begin.\nStep R must be finished before step C can begin.\nStep L must be finished before step S can begin.\nStep V must be finished before step R can begin.\nStep X must be finished before step R can begin.\nStep Z must be finished before step A can begin.\nStep O must be finished before step Z can begin.\nStep U must be finished before step C can begin.\nStep X must be finished before step W can begin.\nStep K must be finished before step O can begin.\nStep O must be finished before step A can begin.\nStep K must be finished before step T can begin.\nStep N must be finished before step O can begin.\nStep X must be finished before step C can begin.\nStep Z must be finished before step C can begin.\nStep N must be finished before step X can begin.\nStep T must be finished before step A can begin.\nStep D must be finished before step O can begin.\nStep M must be finished before step Q can begin.\nStep D must be finished before step C can begin.\nStep U must be finished before step E can begin.\nStep N must be finished before step H can begin.\nStep I must be finished before step U can begin.\nStep N must be finished before step A can begin.\nStep M must be finished before step E can begin.\nStep M must be finished before step V can begin.\nStep P must be finished before step B can begin.\nStep K must be finished before step X can begin.\nStep N must be finished before step S can begin.\nStep S must be finished before step B can begin.\nStep Y must be finished before step W can begin.\nStep K must be finished before step Q can begin.\nStep V must be finished before step S can begin.\nStep E must be finished before step S can begin.\nStep N must be finished before step Z can begin.\nStep P must be finished before step A can begin.\nStep T must be finished before step V can begin.\nStep L must be finished before step D can begin.\nStep I must be finished before step C can begin.\nStep Q must be finished before step E can begin.\nStep Y must be finished before step U can begin.\nStep J must be finished before step I can begin.\nStep P must be finished before step H can begin.\nStep T must be finished before step M can begin.\nStep T must be finished before step E can begin.\nStep D must be finished before step F can begin."
