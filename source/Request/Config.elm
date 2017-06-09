module Request.Config exposing (..)

import Http exposing (Request)
import Request.Util as Api
import Types.Post as Post exposing (Post)
import Types.Message exposing (Message(..))


getCmd : Cmd Message
getCmd =
    Http.send
        (PostMessage << Post.ConfigResponse)
        get


get : Request String
get =
    Http.getString (Api.url "/config.txt")
