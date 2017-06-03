module Main.Subscriptions exposing (subscriptions)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


--import Ports


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none
