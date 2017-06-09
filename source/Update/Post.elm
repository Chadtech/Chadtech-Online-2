module Update.Post exposing (..)

import Http
import Request.Post as Post
import Types.Post
    exposing
        ( Model
        , Message(..)
        , PostType(..)
        , PostState(..)
        )
import Debug exposing (log)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case log "POST MESSAGE" message of
        ConfigResponse (Ok str) ->
            { model
                | postTitles =
                    String.split "\n" str
            }
                |> update CheckForPost

        ConfigResponse (Err err) ->
            model ! []

        PostResponse (Ok post) ->
            { model
                | post = Loaded (log "POST" post)
            }
                ! []

        PostResponse (Err err) ->
            let
                _ =
                    log "ERR" err
            in
                model ! []

        CheckForPost ->
            case model.post of
                Loaded _ ->
                    model ! []

                Loading type_ ->
                    load type_ model


load : PostType -> Model -> ( Model, Cmd Message )
load type_ model =
    loadWhich type_ model
        |> Post.get
        |> Http.send PostResponse
        |> (,) model


loadWhich : PostType -> Model -> Int
loadWhich type_ model =
    case type_ of
        Home ->
            List.length model.postTitles - 1

        Number int ->
            int
