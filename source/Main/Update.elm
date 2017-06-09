module Main.Update exposing (update)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Page as Page
import Route
import Update.Post as Post


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case ( message, model.page ) of
        ( SetRoute route, _ ) ->
            Route.set route model

        ( PostMessage subMessage, Page.Post subModel ) ->
            let
                ( newSubModel, cmd ) =
                    Post.update subMessage subModel
            in
                { model
                    | page = Page.Post newSubModel
                }
                    ! [ Cmd.map PostMessage cmd ]

        _ ->
            model ! []
