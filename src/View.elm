module View exposing (..)

import Actions exposing (..)
import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import ViewModel exposing (Model)
import Svg exposing (..)
import Svg.Attributes exposing (..)

stave =
    [10,13,16,19,22,30,33,36,39,42]
        |> List.map toString
        |> List.map
            (\n ->
                Svg.path
                    [ strokeWidth "0.2"
                    , stroke "black"
                    , d ("M 10 " ++ n ++ " L 90 " ++ n)]
                    []
            )

currentNote model =
    [ circle
        [ cx "50"
        , cy "13"
        , r "1"
        , stroke "black"
        , fill "black" ]
        []
    ]

view : Model -> Html Msg
view model =
    let
        (w, h) =
            (model.windowSize.width, model.windowSize.height)

    in
        svg
            [ width "100%"
            , height "100%"
            , viewBox "0 0 100 100"
            ]
            (stave ++ (currentNote model))
