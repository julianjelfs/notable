module Main exposing (..)

import Actions exposing (..)
import Html exposing (program, programWithFlags)
import Task
import Update exposing (getRandomNote, update)
import View exposing (view)
import ViewModel exposing (Model, initialModel)
import Window


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions }

init : (Model, Cmd Msg)
init =
    (initialModel
    , Cmd.batch
        [ Task.perform WindowSize Window.size
        , getRandomNote ]
    )

subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes WindowSize
