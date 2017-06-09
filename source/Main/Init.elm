module Main.Init exposing (model, init)

import Types.Model exposing (Model(..))
import Types.Message exposing (Message(..))
import Types.Post exposing (PostType(..), PostState(..))
import Navigation exposing (Location)
import Route


init : Location -> ( Model, Cmd Message )
init location =
    Route.set
        (Route.fromLocation location)
        model


model : Model
model =
    Post
        { post = Loading Home
        , postTitles = []
        }
