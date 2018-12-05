module Answers exposing (main)

import DayOne
import DayThree
import DayTwo
import Html exposing (Html, div, h2, h3, p, span, text)
import Html.Attributes exposing (class, style)
import Html.Lazy exposing (lazy, lazy2, lazy3)


main =
    div
        [ style "font-family" "Helvetica"
        , style "flex-wrap" "wrap"
        , style "display" "flex"
        ]
        [ dayDiv "December One" (Just DayOne.partOne) (Just DayOne.partTwo)
        , dayDiv "December Two" (Just DayTwo.partOne) (Just DayTwo.partTwo)
        , dayDiv "December Three" (Just DayThree.partOne) (Just DayThree.partTwo)
        , dayDiv "December Four" Nothing Nothing
        , dayDiv "December Five" Nothing Nothing
        , dayDiv "December Six" Nothing Nothing
        , dayDiv "December Seven" Nothing Nothing
        , dayDiv "December Eight" Nothing Nothing
        , dayDiv "December Nine" Nothing Nothing
        , dayDiv "December Ten" Nothing Nothing
        , dayDiv "December Eleven" Nothing Nothing
        , dayDiv "December Twelve" Nothing Nothing
        , dayDiv "December Thirteen" Nothing Nothing
        , dayDiv "December Fourteen" Nothing Nothing
        , dayDiv "December Fifteen" Nothing Nothing
        , dayDiv "December Sixteen" Nothing Nothing
        , dayDiv "December Seventeen" Nothing Nothing
        , dayDiv "December Eighteen" Nothing Nothing
        , dayDiv "December Nineteen" Nothing Nothing
        , dayDiv "December Twenty" Nothing Nothing
        , dayDiv "December Twenty-One" Nothing Nothing
        , dayDiv "December Twenty-Two" Nothing Nothing
        , dayDiv "December Twenty-Three" Nothing Nothing
        , dayDiv "December Twenty-Four" Nothing Nothing
        , dayDiv "December Twenty-Five" Nothing Nothing
        , div [ class "flex-spacer" ] []
        ]


dayDiv : String -> Maybe String -> Maybe String -> Html msg
dayDiv dayString partOneString partTwoString =
    div
        [ class "day-wrapper" ]
        [ div
            [ class "heading-wrapper" ]
            [ h2 [] [ text dayString ] ]
        , partP "Part One: " partOneString
        , partP "Part Two: " partTwoString
        ]


partP : String -> Maybe String -> Html msg
partP labelString partString =
    p
        (if Nothing == partString then
            [ style "color" "red" ]

         else
            []
        )
        [ span [ class "param-name" ] [ text labelString ]
        , span [ class "param-value" ] [ text (Maybe.withDefault "error" partString) ]
        ]
