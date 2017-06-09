module Main.Update exposing (update)

import Types.Model exposing (Model(..))
import Types.Message exposing (Message(..))
import Route
import Update.Post as Post


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case ( message, model ) of
        ( SetRoute route, _ ) ->
            Route.set route model

        ( PostMessage subMessage, Post state ) ->
            let
                ( newState, cmd ) =
                    Post.update subMessage state
            in
                Post newState ! [ Cmd.map PostMessage cmd ]

        _ ->
            model ! []
