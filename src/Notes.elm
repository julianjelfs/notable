module Notes exposing (..)

{-|
What is the best way to store the notes?

Need to be able to randomly select them so would be good to be able to lookup
by index in an array / dict?

What does each entry look like?

We need to know where to plot the note i.e. a Y coordinate.

Possibly need to know if the note is within or outside the stave
so that we know whether to draw a line fragment with the note
(this could be derived from the Y value I suppose)

Possibly useful to know whether a note is odd or even (is there terminology for that?)
So we know how to draw the line fragment relative to the note
(again this could be derived from the Y value)

We have 52 white keys and 36 black. For the purposes of site reading we only care about the 52
Seven octaves plus a minor third

Let's support various settings:
    middle two octaves
    middle four octaves
    all seven octaves
-}

type NoteType
    = A
    | B
    | C
    | D
    | E
    | F
    | G

type alias Note =
    { type_ : NoteType }

type alias Octave =
    { notes : List Note
    , yOffset : Float
    }
