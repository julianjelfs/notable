module Update exposing (..)

import Actions exposing (..)
import Char
import Notes exposing (..)
import Random as R
import ViewModel exposing (..)
import Ports exposing (answer)

getRandomNote : Mode -> Cmd Msg
getRandomNote mode =
    R.generate RandomNote (randomNote mode)


randomNote : Mode -> R.Generator UniqueNote
randomNote mode =
    let
        (min, max) =
            case mode of
                Easy -> (2,2)
                Medium -> (1,4)
                Hard -> (0,5)
    in
        R.pair (R.int min max) (R.int 65 71)
            |> R.map
                (\(o, n) -> (o, n |> Char.fromCode |> String.fromChar))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize size ->
            ( {model | windowSize = size }, Cmd.none )

        RandomNote note ->
            ({model | currentNote = note, answerStatus = Waiting }, Cmd.none)

        SetMode mode ->
            ( { model | mode = mode }, Cmd.none )

        Guess note ->
            let
                (_, currentNote) =
                    model.currentNote

                correct =
                    note == currentNote

                (summary, status) =
                    case correct of
                        True ->
                            ("Correct! " ++ note ++ " is the right answer"
                            , Right )
                        False ->
                            ("Wrong answer :( try again"
                            , Wrong )
            in
            ( { model
                | summary = summary
                , answerStatus = status
                , lastGuess = Just note }
            , answer { note = currentNote, correct = correct } )

        Tick _ ->
            case model.answerStatus of
                Right ->
                    ( {model | answerStatus = Waiting
                    , summary = "Guess the note..."
                    }, getRandomNote model.mode)
                _ ->
                    (model, Cmd.none)

        Stats pc ->
            ( {model | percentage = pc }, Cmd.none)
