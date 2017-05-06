module Actions exposing (..)

import Window exposing (Size)
import ViewModel exposing (..)

type Msg
    = WindowSize Size
    | RandomNote UniqueNote
    | SetMode Mode
    | Guess String
