module Main.View exposing (view)

import Html exposing (Html, div, p, text, a)
import Html.Attributes exposing (class, classList)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


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
        [ navItem "Blog" True
        , navItem "Resume" False
        , navItem "Archive" False
        , navItem "Chadtech Online 0" False
        , navItem "Twitter" False
        , navItem "Github" False
        ]


navItem : String -> Bool -> Html Message
navItem content isSelected =
    a
        [ classList
            [ ( "nav-item", True )
            , ( "selected", isSelected )
            ]
        ]
        [ text content ]
