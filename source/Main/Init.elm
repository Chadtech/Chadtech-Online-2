module Main.Init exposing (model, init)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Navigation exposing (Location)
import Route


init : Location -> ( Model, Cmd Message )
init location =
    Route.set (Route.fromLocation location) model Cmd.none


model : Model
model =
    { page = Home () }
