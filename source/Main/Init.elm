module Main.Init exposing (model, init)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Navigation exposing (Location)
import Route
import Request.Init as Request
import Http


init : Location -> ( Model, Cmd Message )
init location =
    Route.set
        (Route.fromLocation location)
        model
        [ Http.send ConfigResponse Request.getConfig ]


model : Model
model =
    { page = Home ()
    , postTitles = []
    }
