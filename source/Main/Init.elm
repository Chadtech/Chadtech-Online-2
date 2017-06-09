module Main.Init exposing (model, init)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Types.Post as Post
import Navigation exposing (Location)
import Route
import Request.Config as Config


init : Location -> ( Model, Cmd Message )
init location =
    Route.set
        (Route.fromLocation location)
        model


model : Model
model =
    { page = Post Post.empty }
