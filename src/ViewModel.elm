module ViewModel exposing (AnswerStatus(..), GameStatus(..), Mode(..), Model, Note, NoteStats, Octave, OctaveStats, Stats, UniqueNote, initialModel, mapBoth, percentage, timeAllowed, totalsForOctave)

import Time


timeAllowed : Mode -> Float
timeAllowed mode =
    (case mode of
        Easy ->
            5

        Medium ->
            4

        Hard ->
            3
    )
        |> (*) 1000


type Mode
    = Easy --middle two octaves
    | Medium --middle four octaves
    | Hard --all octaves


type GameStatus
    = Playing
    | Paused


type AnswerStatus
    = Waiting
    | Correct
    | Incorrect


totalsForOctave : OctaveStats -> ( Int, Int ) -> ( Int, Int )
totalsForOctave octave agg =
    octave.notes
        |> List.foldl
            (\n ( c, i ) ->
                ( c + n.correct, i + n.incorrect )
            )
            agg


mapBoth fn =
    Tuple.mapFirst fn >> Tuple.mapSecond fn


percentage : Stats -> Int
percentage stats =
    let
        answers =
            stats.octaves
                |> List.foldl
                    totalsForOctave
                    ( 0, 0 )
    in
    case answers of
        ( 0, 0 ) ->
            0

        ( correct, incorrect ) ->
            let
                fCorrect =
                    toFloat correct

                fIncorrect =
                    toFloat incorrect
            in
            (fCorrect / (fCorrect + fIncorrect)) * 100 |> round


type alias NoteStats =
    { note : String
    , correct : Int
    , incorrect : Int
    }


type alias OctaveStats =
    { octave : Int
    , notes : List NoteStats
    }


type alias Stats =
    { octaves : List OctaveStats }


type alias Model =
    { windowSize : ( Int, Int )
    , currentNote : UniqueNote
    , mode : Mode
    , summary : String
    , answerStatus : AnswerStatus
    , lastGuess : Maybe String
    , stats : Stats
    , showStats : Bool
    , statsOctave : Int
    , time : Float
    , status : GameStatus
    }


type alias Octave =
    Int


type alias Note =
    String


type alias UniqueNote =
    ( Octave, Note )


initialModel : Model
initialModel =
    { windowSize = ( 0, 0 )
    , currentNote = ( 0, "C" )
    , mode = Easy
    , summary = "Guess the note..."
    , answerStatus = Waiting
    , lastGuess = Nothing
    , stats = Stats []
    , showStats = False
    , statsOctave = 0
    , time = timeAllowed Easy
    , status = Paused
    }
