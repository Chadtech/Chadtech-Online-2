module Types.Message exposing (Message(..), Handler)

import Types.Route exposing (Route(..))


type Message
    = SetRoute (Maybe Route)


type alias Handler a =
    a -> Message
