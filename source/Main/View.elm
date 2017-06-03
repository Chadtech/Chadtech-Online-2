module Main.View exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


--import Components.Basics exposing (words, field, mainContainer)


view : Model -> Html Message
view model =
    div
        [ class "main" ]
        [ titleBar
        , navBar
        , div
            [ class "post-body" ]
            []
        ]


titleBar : Html Message
titleBar =
    div
        [ class "title-bar" ]
        [ p
            []
            [ text "Chadtech Online 2" ]
        ]


navBar : Html Message
navBar =
    div
        [ class "nav-bar" ]
        []



--Html.text ""
