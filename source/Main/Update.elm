module Main.Update exposing (update)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Route


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SetRoute route ->
            Route.set route model []

        ConfigResponse (Ok str) ->
            { model
                | postTitles =
                    String.split "\n" str
            }
                ! []

        ConfigResponse (Err err) ->
            model ! []
