module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, (</>), oneOf, Parser)
import Types.Route as Route exposing (Route)
import Types.Page as Page
import Types.Message exposing (Message(..))
import Types.Model exposing (Model)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Route.Home (s "") ]


set : Maybe Route -> Model -> Cmd Message -> ( Model, Cmd Message )
set maybeRoute model cmd =
    case maybeRoute of
        Nothing ->
            { model
                | page = Page.NotFound
            }
                ! [ cmd ]

        Just (Route.Home) ->
            { model
                | page = Page.Home ()
            }
                ! [ cmd ]



-- PUBLIC HELPERS


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
