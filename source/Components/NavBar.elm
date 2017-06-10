module Components.NavBar exposing (view, title)

import Html exposing (Html, div, p, text, a)
import Html.Attributes exposing (class, classList)
import Types.Message exposing (Message(..))
import Types.Route exposing (Route(..))
import Route exposing (href)


-- NAV BAR


view : String -> Html Message
view currentPage =
    div
        [ class "nav-bar" ]
        [ item "Blog" currentPage Home
        , item "Resume" currentPage Resume
        , item "Archive" currentPage Archive
        , item "Chadtech Online 0" currentPage ChadtechOnline0
        , item "Twitter" currentPage Twitter
        , item "Github" currentPage Github
        ]


item : String -> String -> Route -> Html Message
item content currentPage route =
    a
        [ classList
            [ ( "nav-item", True )
            , ( "selected", content == currentPage )
            ]
        , href route
        ]
        [ text content ]



-- TITLE BAR


title : Html Message
title =
    div
        [ class "title-bar" ]
        [ p
            []
            [ text "Chadtech Online 2" ]
        ]
