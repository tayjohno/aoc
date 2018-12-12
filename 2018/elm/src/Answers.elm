module Answers exposing (main)

import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Html exposing (Html, div, h2, h3, p, span, text, textarea)
import Html.Attributes exposing (attribute, class, style)
import Html.Lazy exposing (lazy, lazy2, lazy3)


main =
    div
        [ style "font-family" "Helvetica"
        , style "flex-wrap" "wrap"
        , style "display" "flex"
        ]
        [ dayDiv "December One" Day01.partOne Day01.partTwo Nothing
        , dayDiv "December Two" Day02.partOne Day02.partTwo Nothing
        , dayDiv "December Three" Day03.partOne Day03.partTwo Nothing
        , dayDiv "December Four" Day04.partOne Day04.partTwo Nothing
        , dayDiv "December Five" Day05.partOne Day05.partTwo Nothing
        , dayDiv "December Six" Day06.partOne Day06.partTwo Nothing
        , dayDiv "December Seven" Day07.partOne Day07.partTwo Nothing
        , dayDiv "December Eight" Nothing Nothing Nothing
        , dayDiv "December Nine" Nothing Nothing Nothing
        , dayDiv "December Ten" Nothing Nothing Nothing
        , dayDiv "December Eleven" Nothing Nothing Nothing
        , dayDiv "December Twelve" Nothing Nothing Nothing
        , dayDiv "December Thirteen" Nothing Nothing Nothing
        , dayDiv "December Fourteen" Nothing Nothing Nothing
        , dayDiv "December Fifteen" Nothing Nothing Nothing
        , dayDiv "December Sixteen" Nothing Nothing Nothing
        , dayDiv "December Seventeen" Nothing Nothing Nothing
        , dayDiv "December Eighteen" Nothing Nothing Nothing
        , dayDiv "December Nineteen" Nothing Nothing Nothing
        , dayDiv "December Twenty" Nothing Nothing Nothing
        , dayDiv "December Twenty-One" Nothing Nothing Nothing
        , dayDiv "December Twenty-Two" Nothing Nothing Nothing
        , dayDiv "December Twenty-Three" Nothing Nothing Nothing
        , dayDiv "December Twenty-Four" Nothing Nothing Nothing
        , dayDiv "December Twenty-Five" Nothing Nothing Nothing
        , div [ class "flex-spacer" ] []
        ]


dayDiv : String -> Maybe String -> Maybe String -> Maybe String -> Html msg
dayDiv dayString partOneString partTwoString debugString =
    div
        (if debugString == Nothing then
            [ class "day-wrapper" ]

         else
            [ class "day-wrapper", class "debug" ]
        )
        [ div
            [ class "heading-wrapper" ]
            [ h2 [] [ text dayString ] ]
        , partP "Part One: " partOneString
        , partP "Part Two: " partTwoString
        , textarea [ class "hidden-debug", attribute "readonly" "" ] [ text (Maybe.withDefault "" debugString) ]
        ]


partP : String -> Maybe String -> Html msg
partP labelString partString =
    p
        (if Nothing == partString then
            [ class "param", class "failed" ]

         else
            [ class "param" ]
        )
        [ span [ class "param-name" ] [ text labelString ]
        , span [ class "param-value" ] [ text (Maybe.withDefault "error" partString) ]
        ]
