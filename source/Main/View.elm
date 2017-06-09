module Main.View exposing (view)

import Html exposing (Html, div, p, text, a)
import Html.Attributes exposing (class, classList)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import View.Post as Post
import Components.NavBar as NavBar


view : Model -> Html Message
view model =
    div
        [ class "main" ]
        (body model)


body : Model -> List (Html Message)
body model =
    case model.page of
        Post subModel ->
            Post.view subModel

        _ ->
            [ NavBar.title
            , NavBar.view ""
            ]
