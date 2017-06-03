module Main exposing (..)

import Main.Init exposing (init)
import Main.View exposing (view)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Navigation
import Route


main : Program Never Model Message
main =
    Navigation.program
        (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
