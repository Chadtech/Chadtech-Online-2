module Types.Message exposing (Message(..), Handler)

import Types.Route exposing (Route(..))
import Types.Post as Post


type Message
    = SetRoute (Maybe Route)
    | PostMessage Post.Message


type alias Handler a =
    a -> Message
