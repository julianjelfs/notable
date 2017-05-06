module View exposing (..)

import Actions exposing (..)
import Html as H exposing (Html, button, div, img, text, span)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)
import ViewModel exposing (..)
import Svg as S exposing (..)
import Svg.Attributes exposing (..)

stave : List (Svg Msg)
stave =
    [10,13,16,19,22,30,33,36,39,42]
        |> List.map toString
        |> List.map
            (\n ->
                S.path
                    [ strokeWidth "0.2"
                    , stroke "black"
                    , d ("M 5 " ++ n ++ " L 95 " ++ n)]
                    []
            )

currentNote : Model -> List (Svg Msg)
currentNote model =
    [ circle
        [ cx "50"
        , cy "13"
        , r "1"
        , stroke "black"
        , fill "black" ]
        []
    ]

modeSelector : Model -> Html Msg
modeSelector model =
    div [class "mode-selector"]
        [ button
            [ class "easy"
            , classList [("active", model.mode == Easy )]
            , onClick (SetMode Easy)
            ]
            [ span []
                [ H.text "Easy"]
            , span []
                [ H.text "middle two octaves" ]
            ]
        , button [class "medium"
            , classList [("active", model.mode == Medium )]
            , onClick (SetMode Medium)
            ]
            [ span []
                [ H.text "Medium"]
            , span []
                [ H.text "middle four octaves" ]
            ]
        , button [class "hard"
            , classList [("active", model.mode == Hard )]
            , onClick (SetMode Hard)
            ]
            [ span []
                [ H.text "Hard"]
            , span []
                [ H.text "all octaves" ]
            ]
        ]

view : Model -> Html Msg
view model =
    let
        (w, h) =
            (model.windowSize.width, model.windowSize.height)

    in
        div
            [class "stage"]
            [ modeSelector model
            , svg
                [ width "100%"
                , height "100%"
                , viewBox "0 0 100 100"
                ]
                (stave ++ (currentNote model))
            ]
