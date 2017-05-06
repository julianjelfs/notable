module ViewModel exposing (..)

import Window exposing (Size)

{-|

-}

type alias Model =
    { windowSize : Size
    }



type Note
    = A
    | B
    | C
    | D
    | E
    | F
    | G

initialModel : Model
initialModel =
    { windowSize = Size 0 0 }

