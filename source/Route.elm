module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, int, (</>), oneOf, Parser)
import Types.Route as Route exposing (Route)
import Types.Message exposing (Message(..))
import Types.Model as Model
import Types.Post as Post exposing (empty, Model(..))
import Navigation exposing (Location, modifyUrl)
import Html.Attributes as Attributes
import Html exposing (Attribute)
import Update.Post as PostUpdate


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Route.Home (s "")
        , Url.map Route.Post (s "post" </> int)
        ]


set : Maybe Route -> Model.Model -> Model.Model
set maybeRoute model =
    case maybeRoute of
        Nothing ->
            Model.NotFound

        Just (Route.Home) ->
            goHome model

        Just (Route.Post number) ->
            goToPost number model

        Just (Route.Archive) ->
            model

        _ ->
            model


goHome : Model.Model -> Model.Model
goHome model =
    case model of
        Model.Post state ->
            case state of
                NoTitles _ ->
                    Model.Post empty

                HaveTitles titles _ ->
                    Model.Post (HaveTitles titles Nothing)

                HavePost titles _ ->
                    Model.Post (HaveTitles titles Nothing)

        _ ->
            Model.Post empty


goToPost : Int -> Model.Model -> Model.Model
goToPost postNumber model =
    case model of
        Model.Post state ->
            case state of
                NoTitles _ ->
                    Model.Post (NoTitles (Just postNumber))

                HaveTitles titles _ ->
                    Model.Post (HaveTitles titles (Just postNumber))

                HavePost titles _ ->
                    Model.Post (HaveTitles titles (Just postNumber))

        _ ->
            Model.Post (NoTitles (Just postNumber))


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Route.Home ->
                    [ "#/" ]

                Route.Post int ->
                    [ "#/post", toString int ]

                Route.Archive ->
                    [ "#/archive" ]

                Route.Resume ->
                    [ "#/resume" ]

                Route.ChadtechOnline0 ->
                    [ "http://chadtech.github.io/" ]

                Route.Twitter ->
                    [ "http://www.twitter.com/theRealChadtech" ]

                Route.Github ->
                    [ "http://www.github.com/chadtech" ]
    in
        String.join "/" pieces



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attributes.href (routeToString route)


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
