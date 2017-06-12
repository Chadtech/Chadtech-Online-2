module Main.Init exposing (init)

import Types.Model exposing (Model(..))
import Types.Message exposing (Message(..))
import Navigation exposing (Location)
import Request.Config as Config
import Route


init : Location -> ( Model, Cmd Message )
init location =
    let
        model =
            Route.set (Route.fromLocation location) Blank
    in
        ( model, Config.cmd )
