port module Ports exposing (..)

port answer : {note: String, correct: Bool} -> Cmd msg

port stats : (Float -> msg) -> Sub msg