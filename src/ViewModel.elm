module ViewModel exposing (..)

import Window exposing (Size)

type alias Model =
    { windowSize : Size
    }

initialModel : Model
initialModel =
    { windowSize = Size 0 0 }

