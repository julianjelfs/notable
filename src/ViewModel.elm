module ViewModel exposing (..)

import Time
import Window exposing (Size)

timeAllowed: Mode -> Float
timeAllowed mode =
    (case mode of
        Easy -> 5
        Medium -> 4
        Hard -> 3)
        |> ((*) Time.second)


type Mode
    = Easy      --middle two octaves
    | Medium    --middle four octaves
    | Hard      --all octaves

type GameStatus
    = Playing
    | Paused

type AnswerStatus
    = Waiting
    | Correct
    | Incorrect

totalsForOctave : OctaveStats -> (Int, Int) -> (Int, Int)
totalsForOctave octave agg =
    octave.notes
        |> List.foldl
            (\n (c, i) ->
                (c + n.correct, i + n.incorrect)
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
                    (0,0)
                |> mapBoth toFloat
                |> Debug.log "answers"
    in
        case answers of
            (0,0) -> 0
            (correct, incorrect) ->
                (correct / (correct + incorrect)) * 100 |> round

type alias NoteStats =
    { note: String
    , correct: Int
    , incorrect: Int
    }

type alias OctaveStats =
    { octave: Int
    , notes: List NoteStats
    }

type alias Stats =
    { octaves : List OctaveStats }

type alias Model =
    { windowSize : Size
    , currentNote : UniqueNote
    , mode : Mode
    , summary : String
    , answerStatus : AnswerStatus
    , lastGuess : Maybe String
    , stats : Stats
    , showStats : Bool
    , statsOctave: Int
    , time : Float
    , status : GameStatus
    }

type alias Octave = Int

type alias Note = String

type alias UniqueNote = (Octave, Note)


initialModel : Model
initialModel =
    { windowSize = Size 0 0
    , currentNote = (0,"C")
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

