module Update exposing (..)

import Actions exposing (..)
import ViewModel exposing (Model)

randomNote : Cmd Msg
randomNote =
    Cmd.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize size ->
            ( {model | windowSize = size }, Cmd.none )
