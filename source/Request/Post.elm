module Request.Post exposing (..)

import Http exposing (Request)
import Request.Util as Api
import Types.Post as Post exposing (Post)
import Types.Message exposing (Message(..))


getCmd : Int -> Cmd Message
getCmd postNumber =
    Http.send
        (PostMessage << Post.PostResponse)
        (get postNumber)


get : Int -> Request Post
get postNumber =
    Http.get
        (postRoute <| toString postNumber)
        (Post.decoder postNumber)


postRoute : String -> String
postRoute number =
    if String.length number < 3 then
        postRoute ("0" ++ number)
    else
        Api.url "/posts/" ++ number ++ ".json"
