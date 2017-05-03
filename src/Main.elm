module Main exposing (..)

import Actions exposing (Msg)
import Html exposing (program, programWithFlags)
import Update exposing (update)
import View exposing (view)
import ViewModel exposing (Model, initialModel)


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions }

init : (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
