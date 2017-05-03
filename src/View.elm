module View exposing (..)

import Actions exposing (..)
import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import ViewModel exposing (Model)

view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div [] [ text model.message ]
        ]
