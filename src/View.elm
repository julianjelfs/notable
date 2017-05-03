module View exposing (..)

import Actions exposing (..)
import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import ViewModel exposing (Model)
import Svg exposing (..)
import Svg.Attributes exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div
            []
            [roundRect]
        ]

roundRect : Html Msg
roundRect =
    svg
      [ width "120", height "120", viewBox "0 0 120 120" ]
      [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ]
