module View exposing (..)

import Actions exposing (..)
import Html as H exposing (Html, button, div, img, text, span)
import Html.Attributes as H exposing (classList, style)
import Html.Events exposing (onClick)
import List.Extra
import ViewModel exposing (..)
import Svg as S exposing (..)
import Svg.Attributes exposing (..)
import TrebleClef exposing (trebleClef, baseClef)

trebleLines : List Int
trebleLines =
    [30,34,38,42,46]

baseLines : List Int
baseLines =
    [54,58,62,66,70]

stave : List (Svg Msg)
stave =
    (trebleLines ++ baseLines)
        |> List.map toString
        |> List.map
            (\n ->
                S.path
                    [ strokeWidth "0.2"
                    , stroke "black"
                    , d ("M 5 " ++ n ++ " L 95 " ++ n)]
                    []
            )

baseForOctave : UniqueNote -> Int
baseForOctave (index, _) =
    case index of
        0 -> 92
        1 -> 78
        2 -> 64
        3 -> 50
        4 -> 36
        5 -> 22
        _ -> 0

noteOffset : UniqueNote -> Int
noteOffset (_, note) =
    case note of
        "C" -> 0
        "D" -> -2
        "E" -> -4
        "F" -> -6
        "G" -> -8
        "A" -> -10
        "B" -> -12
        _ -> 0

drawLedger : Int -> List (Svg Msg)
drawLedger ypos =
    let
        direction =
            if ypos > 50 then
                (-)
            else
                (+)

        n =
            (if ypos < 30 then
                (30 - (toFloat ypos)) / 4
            else if ypos > 70 then
                ((toFloat ypos) - 70) / 4
            else if ypos == 50 then
                1.0
            else 0.0 ) |> round

        odd =
            ypos % 4 /= 0

        y =
            (case odd of
                True -> ypos
                False -> direction ypos 2)
    in
        List.range 0 n
            |> List.foldl
                (\n (lines, y) ->
                    let
                        yStr = y |> toString
                    in
                        ( lines ++ ( case (baseLines ++ trebleLines |> List.member y) of
                            True -> []
                            False ->
                                [ S.path
                                    [ strokeWidth "0.2"
                                    , stroke "black"
                                    , d ("M 45 " ++ yStr ++ " L 55 " ++ yStr)]
                                    [] ] ), direction y 4)
                ) ([], y)
            |> Tuple.first




currentNote : Model -> List (Svg Msg)
currentNote model =
    let
        base =
            baseForOctave model.currentNote

        offset =
            noteOffset model.currentNote

        ypos =
            base + offset

        (_, noteTxt) =
            model.currentNote

        note =
            [ circle
                [ cx "50"
                , cy (ypos |> toString)
                , r "1.5"
                , stroke "black"
                , fill "black" ]
                [ ]
--            , S.text_
--                    [ x "50"
--                    , y (ypos |> toString)
--                    , textAnchor "middle"
--                    , stroke "#fff"
--                    , strokeWidth "0"
--                    , dy "1"
--                    , dx "0"
--                    , fontSize "3px"
--                    , fill "#fff" ]
--                    [ S.text noteTxt ]
            ]
    in
        (drawLedger ypos) ++ note


modeButton : Model -> Mode -> String -> String -> String -> Html Msg
modeButton model mode txt sub cls =
    button
        [ class cls
        , classList [("active", model.mode == mode )]
        , onClick (SetMode mode)
        ]
        [ span []
            [ H.text txt]
        , span []
            [ H.text sub ]
        ]

modeSelector : Model -> Html Msg
modeSelector model =
    div [class "mode-selector"]
        [ modeButton model Easy "Easy" "two octaves" "easy"
        , modeButton model Medium "Medium" "four octaves" "medium"
        , modeButton model Hard "Hard" "all octaves" "hard"
        ]

answer : Model -> Html Msg
answer model =
    let
        (_, note) =
            model.currentNote
    in
        div [ class "answer" ]
            (["C","D","E","F","G","A","B"]
                |> List.map
                    (\c ->
                        button
                            [ onClick (Guess c)
                            , classList
                                [("correct", model.answerStatus == Correct && (Just c == model.lastGuess) )
                                ,("incorrect", model.answerStatus == Incorrect && (Just c == model.lastGuess) )]
                            ]
                            [ H.text c ]
                    )
            )

toPercent : Int -> String
toPercent n =
    (n |> toString) ++ "%"

summary: Model -> Html Msg
summary model =
    div [class "summary"]
        [ span
            [ class "score"
            , onClick ToggleStats ]
            [ percentage model.stats |> toPercent |> H.text ]
         , span
            [ class "msg"]
            [ H.text model.summary ]
        ]

stats : Model -> Html Msg
stats model =
    let
        notes =
            model.stats.octaves
                |> List.Extra.find (\o -> o.octave == model.statsOctave)
                |> Maybe.map .notes
                |> Maybe.withDefault []
    in
        div
            [ class "stats" ]
            [ div
                [ class "header" ]
                ((model.stats.octaves
                    |> List.map
                        (\o ->
                            div
                                [classList [("active", model.statsOctave == o.octave)]
                                , onClick (ShowOctave o.octave)]
                                [ H.text <| toString o.octave ] )
                ) ++ [div [onClick ToggleStats] [H.text "<="]])
            , div
                [class "notes"]
                (notes
                    |> List.map
                        (\n ->
                            let
                                correct =
                                    toFloat n.correct

                                incorrect =
                                    toFloat n.incorrect

                                total =
                                    correct + incorrect

                                (pc, pi) =
                                    case total == 0 of
                                        True -> (40,40)
                                        False ->
                                            ( correct / total * 80
                                            , incorrect / total * 80)

                                noteDivs =
                                    [ div
                                        [ class "note-name" ]
                                        [ H.text n.note ]
                                    ]
                            in
                                div
                                    [class "note"]
                                    ( noteDivs
                                        ++ (case pc > 0 of
                                                False -> []
                                                True ->
                                                    [div
                                                        [ class "note-correct"
                                                        , H.style [("width", (toString pc) ++ "%")]
                                                        ]
                                                        [ H.text <| toString n.correct ]]
                                            )
                                        ++ (case pi > 0 of
                                                False -> []
                                                True ->
                                                    [div
                                                        [ class "note-incorrect"
                                                        , H.style [("width", (toString pi) ++ "%")]
                                                        ]
                                                        [ H.text <| toString n.incorrect ]]
                                            )
                                    )
                        )
                )
            ]


footer : Model -> Html Msg
footer model =
    div [class  "footer"]
        [ answer model
        , summary model
        ]

overlay : Model -> Html Msg
overlay model =
    div [classList [("overlay", True), ("active", model.showStats)]]
        [ stats model ]

view : Model -> Html Msg
view model =
    let
        (w, h) =
            (model.windowSize.width, model.windowSize.height)
    in
        div
            [class "stage"]
            [ overlay model
            , modeSelector model
            , svg
                [ width "100%"
                , height "100%"
                , viewBox "0 0 100 95"
                ]
                (trebleClef ++ stave ++ (currentNote model))
            , footer model
            ]

