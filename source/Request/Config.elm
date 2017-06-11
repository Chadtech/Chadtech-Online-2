module Request.Config exposing (..)

import Http exposing (Request, Error)
import Request.Util as Api
import Types.Post as Post exposing (Post)
import Types.Message exposing (Message(..))
import Json.Decode as Decode exposing (Decoder, andThen, succeed, fail)


cmd : Cmd Message
cmd =
    Http.send
        (PostMessage << Post.ConfigResponse << handleTask)
        get


get : Request String
get =
    Http.getString (Api.url "/config.txt")


handleTask : Result Error String -> Result Error (List String)
handleTask result =
    case result of
        Ok str ->
            Ok (String.split "\n" str)

        Err err ->
            Err err
