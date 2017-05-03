module Update exposing (..)

import Actions exposing (..)
import ViewModel exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
