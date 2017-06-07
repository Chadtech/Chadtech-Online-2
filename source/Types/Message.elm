module Types.Message exposing (Message(..), Handler)

import Types.Route exposing (Route(..))
import Http exposing (Error)


type Message
    = SetRoute (Maybe Route)
    | ConfigResponse (Result Error String)


type alias Handler a =
    a -> Message
