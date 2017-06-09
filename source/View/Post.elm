module View.Post exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Types.Post exposing (Model)
import Types.Message exposing (Message(..))
import Components.NavBar as NavBar


view : Model -> List (Html Message)
view model =
    [ NavBar.title
    , NavBar.view "Blog"
    , div
        [ class "post-body" ]
        []
    ]
