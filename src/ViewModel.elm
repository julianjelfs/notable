module ViewModel exposing (..)

import Window exposing (Size)

type Mode
    = Easy      --middle two octaves
    | Medium    --middle four octaves
    | Hard      --all octaves

type alias Model =
    { windowSize : Size
    , currentNote : UniqueNote
    , mode : Mode
    , summary : String
    }

type alias OctaveIndex = Int

type alias NoteIndex = Int

type alias UniqueNote = (OctaveIndex, NoteIndex)


initialModel : Model
initialModel =
    { windowSize = Size 0 0
    , currentNote = (0,0)
    , mode = Easy
    , summary = "Tap the letter of the note that you see on the stave"
    }

