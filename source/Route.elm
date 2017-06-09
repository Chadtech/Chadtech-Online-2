module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, int, (</>), oneOf, Parser)
import Types.Route as Route exposing (Route)
import Types.Page as Page exposing (Page)
import Types.Message exposing (Message(..))
import Types.Model exposing (Model)
import Types.Post as Post exposing (PostState(..))
import Request.Post
import Request.Config as Config
import Navigation exposing (Location)
import Debug exposing (log)


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Route.Home (s "")
        , Url.map Route.Post (s "post" </> int)
        ]


set : Maybe Route -> Model -> ( Model, Cmd Message )
set maybeRoute model =
    case log "ROUTE" maybeRoute of
        Nothing ->
            { model
                | page = Page.NotFound
            }
                ! []

        Just (Route.Home) ->
            let
                ( page, cmd ) =
                    goHome model.page
            in
                ( { model | page = page }, cmd )

        _ ->
            model ! []


goHome : Page -> ( Page, Cmd Message )
goHome page =
    case page of
        Page.Post { postTitles } ->
            case postTitles of
                [] ->
                    ( Page.Post Post.empty, Config.getCmd )

                titles ->
                    let
                        postNumber =
                            List.length titles - 1

                        model =
                            Page.Post
                                { post = Loading (Post.Number postNumber)
                                , postTitles = titles
                                }
                    in
                        ( model, Request.Post.getCmd postNumber )

        _ ->
            ( Page.Post Post.empty, Config.getCmd )


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
