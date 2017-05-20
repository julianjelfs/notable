module Main exposing (..)

import Actions exposing (..)
import Html exposing (program, programWithFlags)
import Task
import Update exposing (getRandomNote, update)
import View exposing (view)
import ViewModel exposing (..)
import Window
import Time
import Ports exposing (receiveStats)
import Json.Encode as Encode
import Json.Decode as Decode
import AnimationFrame exposing (diffs)


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

noteStatsDecoder : Decode.Decoder NoteStats
noteStatsDecoder =
    Decode.map3 NoteStats
        (Decode.field "note" Decode.string)
        (Decode.field "correct" Decode.int)
        (Decode.field "incorrect" Decode.int)

octaveStatsDecoder : Decode.Decoder OctaveStats
octaveStatsDecoder =
    Decode.map2 OctaveStats
        (Decode.field "octave" Decode.int)
        (Decode.field "notes" (Decode.list noteStatsDecoder))

statsDecoder : Decode.Decoder Stats
statsDecoder =
    Decode.map Stats
        (Decode.field "octaves" (Decode.list octaveStatsDecoder))

decodeStats : Encode.Value -> Stats
decodeStats encoded =
    let
        res =
            Decode.decodeValue
                statsDecoder
                encoded
    in
        case res of
            Err err ->
                let
                    e = Debug.log "Error" err
                in
                    Stats []
            Ok s ->
                s

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes WindowSize
        , receiveStats (decodeStats >> ReceiveStats)
        , (if model.status == Playing then diffs Tick else Sub.none) ]
