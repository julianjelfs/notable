module ViewModel exposing (..)

type alias Model =
    { message : String
    , logo : String
    }

initialModel : Model
initialModel =
    { message = "Your Elm App is working!", logo = "" }

