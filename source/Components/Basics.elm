module Components.Basics exposing (..)

import Html exposing (Html, p, input, div)
import Html.Attributes exposing (class, value, spellcheck, placeholder)
import Html.Events exposing (onInput)
import Types.Message exposing (Message(..), Handler)


field : Handler String -> String -> String -> Html Message
field handler placeholder_ value_ =
    input
        [ class "field"
        , value value_
        , onInput handler
        , placeholder placeholder_
        ]
        []


words : String -> String -> Html Message
words class_ words =
    p [ class class_ ] [ Html.text words ]


mainContainer : List (Html Message) -> Html Message
mainContainer =
    div [ class "main" ]
