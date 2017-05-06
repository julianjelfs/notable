module Update exposing (..)

import Actions exposing (..)
import Char
import Notes exposing (..)
import Random as R
import ViewModel exposing (..)

getRandomNote : Cmd Msg
getRandomNote =
    R.generate RandomNote randomNote


randomNote : R.Generator UniqueNote
randomNote =
    R.pair (R.int 0 6) (R.int 65 71)
        |> R.map
            (\(o, n) -> (o, n |> Char.fromCode |> String.fromChar))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize size ->
            ( {model | windowSize = size }, Cmd.none )

        RandomNote note ->
            ({model | currentNote = (Debug.log "Note" note)}, Cmd.none)

        SetMode mode ->
            ( { model | mode = mode }, Cmd.none )

        Guess note ->
            let
                correct =
                    note == (model.currentNote |> Tuple.second)

                (summary, fx) =
                    case correct of
                        True ->
                            ("Well done! " ++ note ++ " is the right answer. What's next?"
                            , getRandomNote )
                        False ->
                            ("Nope that's the wrong answer. Try again"
                            , Cmd.none )
            in
            ( { model | summary = summary }
            , fx )
