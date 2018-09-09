module Actions exposing (Msg(..))

import ViewModel exposing (..)


type Msg
    = WindowSize Int Int
    | RandomNote UniqueNote
    | SetMode Mode
    | Guess String
    | Tick Float
    | ReceiveStats Stats
    | ToggleStats
    | ShowOctave Int
    | ToggleStatus
