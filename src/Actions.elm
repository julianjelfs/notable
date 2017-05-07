module Actions exposing (..)

import Time exposing (Time)
import Window exposing (Size)
import ViewModel exposing (..)

type Msg
    = WindowSize Size
    | RandomNote UniqueNote
    | SetMode Mode
    | Guess String
    | Tick Time
    | Stats Float
