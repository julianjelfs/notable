module Update exposing (..)

import Actions exposing (..)
import Notes exposing (..)
import Random exposing (..)
import ViewModel exposing (..)

getRandomNote : Cmd Msg
getRandomNote =
    generate RandomNote randomNote


randomNote : Generator UniqueNote
randomNote =
    pair (int 0 6) (int 0 6)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize size ->
            ( {model | windowSize = size }, Cmd.none )

        RandomNote note ->
            ({model | currentNote = (Debug.log "Note" note)}, Cmd.none)

        SetMode mode ->
            ( { model | mode = mode }, Cmd.none )
