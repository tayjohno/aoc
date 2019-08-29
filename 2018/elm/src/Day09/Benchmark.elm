module Day09.Benchmark exposing (benchmark, main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Day09.MarbleCircle exposing (newGame, playTo, winningScore)


benchmark =
    Benchmark.describe "Day09"
        [ Benchmark.benchmark "1.0%" (\_ -> newGame 439 |> playTo 713 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.9%" (\_ -> newGame 439 |> playTo 641 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.8%" (\_ -> newGame 439 |> playTo 570 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.7%" (\_ -> newGame 439 |> playTo 499 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.6%" (\_ -> newGame 439 |> playTo 427 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.5%" (\_ -> newGame 439 |> playTo 356 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.4%" (\_ -> newGame 439 |> playTo 285 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.3%" (\_ -> newGame 439 |> playTo 213 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.2%" (\_ -> newGame 439 |> playTo 142 |> winningScore |> String.fromInt)
        , Benchmark.benchmark "0.1%" (\_ -> newGame 439 |> playTo 71 |> winningScore |> String.fromInt)

        -- Benchmark.benchmark "01/10" (\_ -> newGame 439 |> playTo 7130 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "02/10" (\_ -> newGame 439 |> playTo 14261 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "03/10" (\_ -> newGame 439 |> playTo 21392 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "04/10" (\_ -> newGame 439 |> playTo 28523 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "05/10" (\_ -> newGame 439 |> playTo 35653 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "06/10" (\_ -> newGame 439 |> playTo 42784 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "07/10" (\_ -> newGame 439 |> playTo 49915 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "08/10" (\_ -> newGame 439 |> playTo 57046 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "09/10" (\_ -> newGame 439 |> playTo 64175 |> winningScore |> String.fromInt)
        -- , Benchmark.benchmark "10/10" (\_ -> newGame 439 |> playTo 71307 |> winningScore |> String.fromInt)
        ]


main =
    program benchmark
