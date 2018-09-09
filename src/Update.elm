module Update exposing (getRandomNote, randomNote, update)

import Actions exposing (..)
import Char
import Ports exposing (answer)
import Random as R
import ViewModel exposing (..)


getRandomNote : Mode -> Cmd Msg
getRandomNote mode =
    R.generate RandomNote (randomNote mode)


randomNote : Mode -> R.Generator UniqueNote
randomNote mode =
    let
        ( min, max ) =
            case mode of
                Easy ->
                    ( 2, 3 )

                Medium ->
                    ( 1, 4 )

                Hard ->
                    ( 0, 5 )
    in
    R.pair (R.int min max) (R.int 65 71)
        |> R.map
            (\( o, n ) -> ( o, n |> Char.fromCode |> String.fromChar ))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize width height ->
            ( { model | windowSize = ( width, height ) }, Cmd.none )

        RandomNote note ->
            ( { model | currentNote = note, answerStatus = Waiting }, Cmd.none )

        SetMode mode ->
            ( { model | mode = mode }, Cmd.none )

        ShowOctave o ->
            ( { model | statsOctave = o }, Cmd.none )

        Guess note ->
            let
                ( octave, currentNote ) =
                    model.currentNote

                correct =
                    note == currentNote

                ( ( summary, status ), ( cmd, time ) ) =
                    case correct of
                        True ->
                            ( ( "Correct! " ++ note ++ " is the right answer"
                              , Waiting
                              )
                            , ( getRandomNote model.mode
                              , timeAllowed model.mode
                              )
                            )

                        False ->
                            ( ( "Wrong answer :( try again"
                              , Incorrect
                              )
                            , ( Cmd.none
                              , model.time
                              )
                            )
            in
            ( { model
                | summary = summary
                , answerStatus = status
                , time = time
                , lastGuess = Just note
              }
            , Cmd.batch
                [ answer
                    { octave = octave
                    , note = currentNote
                    , correct = correct
                    }
                , cmd
                ]
            )

        Tick t ->
            let
                ( octave, note ) =
                    model.currentNote

                time =
                    model.time - t
            in
            if time <= 0 then
                ( { model | time = timeAllowed model.mode }
                , Cmd.batch
                    [ answer
                        { octave = octave
                        , note = note
                        , correct = False
                        }
                    , getRandomNote model.mode
                    ]
                )

            else
                ( { model | time = time }, Cmd.none )

        ToggleStats ->
            ( { model | showStats = not model.showStats }, Cmd.none )

        ToggleStatus ->
            ( { model
                | status =
                    case model.status of
                        Playing ->
                            Paused

                        Paused ->
                            Playing
              }
            , Cmd.none
            )

        ReceiveStats stats ->
            ( { model | stats = stats }, Cmd.none )
