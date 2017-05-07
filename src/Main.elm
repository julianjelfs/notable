module Main exposing (..)

import Actions exposing (..)
import Html exposing (program, programWithFlags)
import Task
import Update exposing (getRandomNote, update)
import View exposing (view)
import ViewModel exposing (..)
import Window
import Time
import Ports exposing (stats)


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions }

init : (Model, Cmd Msg)
init =
    let
        model =
            initialModel
    in
        (model
        , Cmd.batch
            [ Task.perform WindowSize Window.size
            , getRandomNote model.mode ]
        )

subscriptions : Model -> Sub Msg
subscriptions model =
    let
        subs =
            [ Window.resizes WindowSize
            , stats Stats ]
    in
        (if model.answerStatus == Right then
            subs ++ [ Time.every (Time.second * 0.5) Tick ]
        else
            subs)
            |> Sub.batch
