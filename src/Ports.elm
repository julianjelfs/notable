port module Ports exposing (answer, receiveStats)

import Json.Encode as Encode


port answer : { octave : Int, note : String, correct : Bool } -> Cmd msg


port receiveStats : (Encode.Value -> msg) -> Sub msg
