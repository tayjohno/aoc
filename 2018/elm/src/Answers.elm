module Answers exposing (main)

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
    , state : DayState
    , partOne : () -> Maybe String
    , partTwo : () -> Maybe String
    , debugString : Maybe String
    }


type DayState
    = Pending
    | Loading
    | Loaded PartState PartState


type PartState
    = Solved String -- Represents a part that has been solved
    | Unsolved


main =
    div
        [ style "font-family" "Helvetica"
        , style "flex-wrap" "wrap"
        , style "display" "flex"
        ]
        [ dayDiv
            { name = "December One"
            , state = Pending
            , partOne = Day01.partOne
            , partTwo = Day01.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Two"
            , state = Pending
            , partOne = Day02.partOne
            , partTwo = Day02.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Three"
            , state = Pending
            , partOne = Day03.partOne
            , partTwo = Day03.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Four"
            , state = Pending
            , partOne = Day04.partOne
            , partTwo = Day04.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Five"
            , state = Pending
            , partOne = Day05.partOne
            , partTwo = Day05.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Six"
            , state = Pending
            , partOne = Day06.partOne
            , partTwo = Day06.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Seven"
            , state = Pending
            , partOne = Day07.partOne
            , partTwo = Day07.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Eight"
            , state = Pending
            , partOne = Day08.partOne
            , partTwo = Day08.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Nine"
            , state = Pending
            , partOne = Day09.partOne
            , partTwo = Day09.partTwo
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Ten"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Eleven"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twelve"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Thirteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Fourteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Fifteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Sixteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Seventeen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Eighteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Nineteen"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty-One"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty-Two"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty-Three"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty-Four"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , dayDiv
            { name = "December Twenty-Five"
            , state = Pending
            , partOne = \_ -> Nothing
            , partTwo = \_ -> Nothing
            , debugString = Nothing
            }
        , div [ class "flex-spacer" ] []
        ]


dayDiv : Day -> Html msg
dayDiv day =
    div
        (if day.state == Pending then
            [ class "day-wrapper", class "pending" ]

         else if day.debugString == Nothing then
            [ class "day-wrapper" ]

         else
            [ class "day-wrapper", class "debug" ]
        )
        [ div
            [ class "heading-wrapper" ]
            [ h2 [] [ text day.name ] ]
        , partField "Part One: " (day.partOne ())
        , partField "Part Two: " (day.partTwo ())
        , textarea [ class "hidden-debug", attribute "readonly" "" ] [ text (Maybe.withDefault "" day.debugString) ]
        ]


partField : String -> Maybe String -> Html msg
partField labelString partString =
    p
        (if Nothing == partString then
            [ class "param", class "failed" ]

         else
            [ class "param" ]
        )
        [ span [ class "param-name" ] [ text labelString ]
        , span [ class "param-value" ] [ text (Maybe.withDefault "error" partString) ]
        ]
