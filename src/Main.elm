module Main exposing (decodeStats, init, main, noteStatsDecoder, octaveStatsDecoder, statsDecoder, subscriptions)

import Actions exposing (..)
import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode
import Ports exposing (receiveStats)
import Task
import Time
import Update exposing (getRandomNote, update)
import View exposing (view)
import ViewModel exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        model =
            initialModel
    in
    ( model
    , Cmd.batch
        [ Task.perform
            (\v -> WindowSize (round v.scene.width) (round v.scene.height))
            Dom.getViewport
        , getRandomNote model.mode
        ]
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
            Stats []

        Ok s ->
            s


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Events.onResize WindowSize
        , receiveStats (decodeStats >> ReceiveStats)
        , if model.status == Playing then
            Events.onAnimationFrameDelta Tick

          else
            Sub.none
        ]
