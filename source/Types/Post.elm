module Types.Post exposing (..)

import Json.Decode.Pipeline exposing (decode, required, hardcoded)
import Json.Decode as Decode exposing (Decoder, andThen, succeed, fail)
import Http exposing (Error)
import Debug exposing (log)


type Message
    = ConfigResponse (Result Error String)
    | PostResponse (Result Error Post)
    | CheckForPost


type PostState
    = Loading PostType
    | Loaded Post


type PostType
    = Home
    | Number Int


type alias Post =
    { title : String
    , date : String
    , body : List Paragraph
    }


type Paragraph
    = Normal (List String)
    | Logic (List String)
    | Image String


type alias Model =
    { post : PostState
    , postTitles : List String
    }


empty : Model
empty =
    { post = Loading Home
    , postTitles = []
    }


error : Post
error =
    { title = "Error"
    , date = "XXXXXXXX"
    , body =
        [ Normal [ "Error loading the post" ]
        ]
    }



-- DECODER


decoder : Decoder Post
decoder =
    decode Post
        |> required "title" Decode.string
        |> required "date" Decode.string
        |> required "body" (Decode.list paragraphDecoder)


paragraphDecoder : Decoder Paragraph
paragraphDecoder =
    Decode.field "type" Decode.string
        |> andThen toParagraph


toParagraph : String -> Decoder Paragraph
toParagraph type_ =
    case type_ of
        "logic" ->
            getContent Logic (Decode.list Decode.string)

        "normal" ->
            getContent Normal (Decode.list Decode.string)

        "image" ->
            getContent Image Decode.string

        _ ->
            fail "not logic normal or image type paragraph"


getContent : (a -> Paragraph) -> Decoder a -> Decoder Paragraph
getContent paragraph decoder_ =
    Decode.map paragraph (Decode.field "content" decoder_)
