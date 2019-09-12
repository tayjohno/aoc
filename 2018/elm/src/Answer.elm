module Answer exposing (Answer(..))


type Answer a
    = Solved a
    | Faked a
    | Unsolved
