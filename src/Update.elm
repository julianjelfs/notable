module Update exposing (..)

import Actions exposing (..)
import Char
import Notes exposing (..)
import Random as R
import ViewModel exposing (..)

getRandomNote : Mode -> Cmd Msg
getRandomNote mode =
    R.generate RandomNote (randomNote mode)


randomNote : Mode -> R.Generator UniqueNote
randomNote mode =
    let
        (min, max) =
            case mode of
                Easy -> (2,3)
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
                correct =
                    note == (model.currentNote |> Tuple.second)

                (summary, status) =
                    case correct of
                        True ->
                            ("Well done! " ++ note ++ " is the right answer. What's next?"
                            , Right )
                        False ->
                            ("Nope that's the wrong answer. Try again"
                            , Wrong )
            in
            ( { model
                | summary = summary
                , answerStatus = status
                , lastGuess = Just note }
            , Cmd.none )

        Tick _ ->
            case model.answerStatus of
                Right ->
                    ( {model | answerStatus = Waiting
                    , summary = "Tap the letter of the note that you see on the stave"
                    }, getRandomNote model.mode)
                _ ->
                    (model, Cmd.none)
