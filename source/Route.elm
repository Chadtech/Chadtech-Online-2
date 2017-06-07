module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, int, (</>), oneOf, Parser)
import Types.Route as Route exposing (Route)
import Types.Page as Page
import Types.Message exposing (Message(..))
import Types.Model exposing (Model)
import Types.Post as Post
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Route.Home (s "")
        , Url.map Route.Post (s "post" </> int)
        ]


set : Maybe Route -> Model -> List (Cmd Message) -> ( Model, Cmd Message )
set maybeRoute model cmds =
    case maybeRoute of
        Nothing ->
            { model
                | page = Page.NotFound
            }
                ! cmds

        Just (Route.Home) ->
            { model
                | page = Page.Home ()
            }
                ! cmds

        Just (Route.Post number) ->
            { model
                | page = Page.Post (Post.Loading number)
            }
                ! cmds



-- PUBLIC HELPERS


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
