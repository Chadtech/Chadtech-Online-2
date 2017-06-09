module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, int, (</>), oneOf, Parser)
import Types.Route as Route exposing (Route)
import Types.Message exposing (Message(..))
import Types.Model exposing (Model(..))
import Types.Post exposing (PostState(..), PostType(..), empty)
import Request.Post
import Request.Config as Config
import Navigation exposing (Location, modifyUrl)
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
            NotFound ! []

        Just (Route.Home) ->
            goHome model

        Just (Route.Archive) ->
            model ! [ modifyUrl "/archive" ]

        _ ->
            model ! []


goHome : Model -> ( Model, Cmd Message )
goHome model =
    case model of
        Post { postTitles } ->
            case postTitles of
                [] ->
                    ( Post empty, Config.getCmd )

                titles ->
                    let
                        postNumber =
                            List.length titles - 1

                        model =
                            Post
                                { post = Loading (Number postNumber)
                                , postTitles = titles
                                }
                    in
                        model ! [ Request.Post.getCmd postNumber, modifyUrl "/" ]

        _ ->
            Post empty ! [ Config.getCmd ]


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
