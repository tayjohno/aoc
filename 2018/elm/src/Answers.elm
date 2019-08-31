module Answers exposing (main)

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
import Html exposing (Html, div, h2, h3, p, span, text, textarea)
import Html.Attributes exposing (attribute, class, style)
import Html.Lazy exposing (lazy, lazy2, lazy3)


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
    = Reset
    | Stuff
    | Things



-- MODEL


type alias Model =
    { dayConfiguration : List Day }


initialModel =
    { dayConfiguration = initialConfiguration }


newDay : String -> (() -> Maybe String) -> (() -> Maybe String) -> Day
newDay name partOne partTwo =
    { name = name
    , partOne = Pending partOne
    , partTwo = Pending partTwo
    , debugString = Nothing
    }


initialConfiguration : List Day
initialConfiguration =
    [ newDay "December One" (\_ -> Nothing) (\_ -> Nothing) -- Day01.partOne Day01.partTwo
    , newDay "December Two" (\_ -> Nothing) (\_ -> Nothing) -- Day02.partOne Day02.partTwo
    , newDay "December Three" (\_ -> Nothing) (\_ -> Nothing) -- Day03.partOne Day03.partTwo
    , newDay "December Four" (\_ -> Nothing) (\_ -> Nothing) -- Day04.partOne Day04.partTwo
    , newDay "December Five" (\_ -> Nothing) (\_ -> Nothing) -- Day05.partOne Day05.partTwo
    , newDay "December Six" (\_ -> Nothing) (\_ -> Nothing) -- Day06.partOne Day06.partTwo
    , newDay "December Seven" (\_ -> Nothing) (\_ -> Nothing) -- Day07.partOne Day07.partTwo
    , newDay "December Eight" (\_ -> Nothing) (\_ -> Nothing) -- Day08.partOne Day08.partTwo
    , newDay "December Nine" (\_ -> Nothing) (\_ -> Nothing) -- Day09.partOne Day09.partTwo
    , newDay "December Ten" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Eleven" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twelve" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Thirteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Fourteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Fifteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Sixteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Seventeen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Eighteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Nineteen" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty-One" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty-Two" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty-Three" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty-Four" (\_ -> Nothing) (\_ -> Nothing)
    , newDay "December Twenty-Five" (\_ -> Nothing) (\_ -> Nothing)
    ]


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
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


update : Msg -> Model -> Model
update _ model =
    model


dayDiv : Day -> Html msg
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
        , partField "Part One: " day.partOne
        , partField "Part Two: " day.partTwo
        , textarea [ class "hidden-debug", attribute "readonly" "" ] [ text (Maybe.withDefault "test test test" day.debugString) ]
        ]


partField : String -> SolutionStatus -> Html msg
partField labelString solution =
    p
        ([ class "param" ]
            |> List.append (solutionAttributes solution)
        )
        [ span [ class "param-name" ] [ text labelString ]
        , span [ class "param-value" ] [ text (solutionText solution) ]
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
