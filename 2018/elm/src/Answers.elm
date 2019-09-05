module Answers exposing (main)

import Basics as Never exposing (Never)
import Browser
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Day09
import Html exposing (Html, button, div, h2, p, span, text, textarea)
import Html.Attributes exposing (attribute, class, style)
import Html.Events exposing (onClick)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Process
import Task exposing (Task)


type alias Day =
    { name : String
    , partOne : SolutionStatus
    , partTwo : SolutionStatus
    , debugString : Maybe String
    }


type SolutionStatus
    = Pending (() -> Maybe String)
    | Solving (() -> Maybe String)
    | Solved (Maybe String)


type Msg
    = Updated Day
    | CalculatePartOne Day
    | CalculatePartTwo Day



-- MODEL


type alias Model =
    { dayConfiguration : List Day }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        day =
            initialConfiguration |> firstDay
    in
    ( { dayConfiguration = initialConfiguration }
    , Process.sleep 100
        |> Task.andThen (\_ -> Task.succeed (Updated { day | partOne = solve day.partOne }))
        |> Task.perform identity
    )


newDay : String -> (() -> Maybe String) -> (() -> Maybe String) -> Day
newDay name partOne partTwo =
    { name = name
    , partOne = Pending partOne
    , partTwo = Pending partTwo
    , debugString = Nothing
    }


firstDay : List Day -> Day
firstDay days =
    days
        |> List.head
        |> Maybe.withDefault (newDay "December One" Day01.partOne Day01.partTwo)


notImplemented : () -> Maybe String
notImplemented _ =
    Nothing


initialConfiguration : List Day
initialConfiguration =
    [ newDay "December One" Day01.partOne Day01.partTwo
    , newDay "December Two" Day02.partOne Day02.partTwo
    , newDay "December Three" Day03.partOne Day03.partTwo
    , newDay "December Four" Day04.partOne Day04.partTwo
    , newDay "December Five" Day05.partOne Day05.partTwo
    , newDay "December Six" Day06.partOne Day06.partTwo
    , newDay "December Seven" Day07.partOne Day07.partTwo
    , newDay "December Eight" Day08.partOne Day08.partTwo
    , newDay "December Nine" notImplemented notImplemented
    , newDay "December Ten" notImplemented notImplemented
    , newDay "December Eleven" notImplemented notImplemented
    , newDay "December Twelve" notImplemented notImplemented
    , newDay "December Thirteen" notImplemented notImplemented
    , newDay "December Fourteen" notImplemented notImplemented
    , newDay "December Fifteen" notImplemented notImplemented
    , newDay "December Sixteen" notImplemented notImplemented
    , newDay "December Seventeen" notImplemented notImplemented
    , newDay "December Eighteen" notImplemented notImplemented
    , newDay "December Nineteen" notImplemented notImplemented
    , newDay "December Twenty" notImplemented notImplemented
    , newDay "December Twenty-One" notImplemented notImplemented
    , newDay "December Twenty-Two" notImplemented notImplemented
    , newDay "December Twenty-Three" notImplemented notImplemented
    , newDay "December Twenty-Four" notImplemented notImplemented
    , newDay "December Twenty-Five" notImplemented notImplemented
    ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- VIEW


view : Model -> Html.Html Msg
view model =
    div
        [ style "font-family" "Helvetica"
        , style "flex-wrap" "wrap"
        , style "display" "flex"
        ]
        (model.dayConfiguration
            |> List.map (\a -> dayDiv a)
            |> prepend [ div [ class "flex-spacer" ] [] ]
        )


prepend : List a -> List a -> List a
prepend a b =
    List.append b a



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Updated day ->
            ( { model | dayConfiguration = updateDayList day model.dayConfiguration }
            , doNextThing model day
            )

        CalculatePartOne day ->
            case day.partOne of
                Pending method ->
                    ( { model | dayConfiguration = updateDayList { day | partOne = Solving method } model.dayConfiguration }
                    , delayedStartPartOne day
                    )

                _ ->
                    ( model, Cmd.none )

        CalculatePartTwo day ->
            case day.partTwo of
                Pending method ->
                    ( { model | dayConfiguration = updateDayList { day | partTwo = Solving method } model.dayConfiguration }
                    , delayedStartPartTwo day
                    )

                _ ->
                    ( model, Cmd.none )


doNextThing : Model -> Day -> Cmd Msg
doNextThing model day =
    case ( day.partOne, day.partTwo ) of
        ( Solved _, Solved _ ) ->
            case getNextDay model.dayConfiguration day of
                Nothing ->
                    Debug.log "oops" Cmd.none

                Just nextDay ->
                    doNextThing model nextDay

        ( Solved _, _ ) ->
            Task.succeed (CalculatePartTwo day)
                |> Task.perform identity

        _ ->
            Task.succeed (CalculatePartOne day)
                |> Task.perform identity


getNextDay : List Day -> Day -> Maybe Day
getNextDay days day =
    case days of
        [] ->
            Nothing

        head :: tail ->
            if head.name == day.name then
                List.head tail

            else
                getNextDay tail day


delayedStartPartOne : Day -> Cmd Msg
delayedStartPartOne day =
    Process.sleep 200
        |> Task.andThen (\_ -> Task.succeed (Updated { day | partOne = solve day.partOne }))
        |> Task.perform identity


delayedStartPartTwo : Day -> Cmd Msg
delayedStartPartTwo day =
    Process.sleep 200
        |> Task.andThen (\_ -> Task.succeed (Updated { day | partTwo = solve day.partTwo }))
        |> Task.perform identity


solve : SolutionStatus -> SolutionStatus
solve status =
    case status of
        Solved _ ->
            status

        Solving method ->
            Solved (method ())

        Pending method ->
            Solved (method ())


{-| Takes a list of days and an updated day and replaces that day in the list with it's new value
-}
updateDayList : Day -> List Day -> List Day
updateDayList day list =
    case list of
        [] ->
            []

        head :: tail ->
            if day.name == head.name then
                day :: tail

            else
                head :: updateDayList day tail



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


dayDiv : Day -> Html Msg
dayDiv day =
    div
        (case ( day.partOne, day.partTwo ) of
            ( Pending _, Pending _ ) ->
                [ class "day-wrapper", class "pending" ]

            ( Solved _, Solved _ ) ->
                [ class "day-wrapper", class "solved" ]

            ( _, _ ) ->
                [ class "day-wrapper", class "solving" ]
        )
        [ div
            [ class "heading-wrapper" ]
            [ h2 [] [ text day.name ] ]
        , solutionFields "Part One:" (CalculatePartOne day) day.partOne
        , solutionFields "Part Two:" (CalculatePartTwo day) day.partTwo
        , textarea [ class "hidden-debug", attribute "readonly" "" ] [ text (Maybe.withDefault "test test test" day.debugString) ]
        ]


solutionFields : String -> Msg -> SolutionStatus -> Html Msg
solutionFields titleString calculateMessage solutionStatus =
    p
        ([ class "param" ]
            |> List.append (solutionAttributes solutionStatus)
        )
        [ span [ class "param-name" ] [ text titleString ]
        , text " "
        , span [ class "param-value" ] [ text (solutionText solutionStatus) ]
        ]


solutionText : SolutionStatus -> String
solutionText solution =
    case solution of
        Pending _ ->
            "Pending"

        Solving _ ->
            "Solving"

        Solved value ->
            Maybe.withDefault "Nothing" value


solutionAttributes : SolutionStatus -> List (Html.Attribute msg)
solutionAttributes solution =
    case solution of
        Solved value ->
            if Nothing == value then
                [ class "failed" ]

            else
                [ class "solved" ]

        Pending _ ->
            [ class "pending" ]

        Solving _ ->
            [ class "solving" ]
