port module Ports exposing (..)

port answer : {octave: Int, note: String, correct: Bool} -> Cmd msg

port stats : (Float -> msg) -> Sub msg
