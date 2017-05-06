module ViewModel exposing (..)

import Window exposing (Size)

type Mode
    = Easy      --middle two octaves
    | Medium    --middle four octaves
    | Hard      --all octaves

type AnswerStatus
    = Waiting
    | Right
    | Wrong

type alias Model =
    { windowSize : Size
    , currentNote : UniqueNote
    , mode : Mode
    , summary : String
    , answerStatus : AnswerStatus
    , lastGuess : Maybe String
    , percentage : Float
    }

type alias Octave = Int

type alias Note = String

type alias UniqueNote = (Octave, Note)


initialModel : Model
initialModel =
    { windowSize = Size 0 0
    , currentNote = (0,"C")
    , mode = Easy
    , summary = "Tap the letter of the note that you see on the stave"
    , answerStatus = Waiting
    , lastGuess = Nothing
    , percentage = 0
    }

