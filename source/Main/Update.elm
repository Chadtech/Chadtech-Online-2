module Main.Update exposing (update)

import Types.Model exposing (Model(..))
import Types.Message exposing (Message(..))
import Types.Post as Post
import Types.Route as Routes
import Route
import Update.Post as Post


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case ( message, model ) of
        ( SetRoute route, _ ) ->
            setRoute route model

        ( PostMessage subMessage, Post state ) ->
            let
                ( newState, cmd ) =
                    Post.update subMessage state
            in
                (Post newState)
                    ! [ Cmd.map PostMessage cmd ]

        _ ->
            model ! []


setRoute : Maybe Routes.Route -> Model -> ( Model, Cmd Message )
setRoute route model =
    let
        newModel =
            Route.set route model
    in
        case newModel of
            Post state ->
                let
                    ( newState, postCmd ) =
                        Post.update Post.NoOp state

                    cmds =
                        [ Cmd.map PostMessage postCmd ]
                in
                    (Post newState) ! cmds

            _ ->
                ( newModel, Cmd.none )
