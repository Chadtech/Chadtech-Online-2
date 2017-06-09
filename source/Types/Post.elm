module Types.Post exposing (..)

import Json.Decode.Pipeline exposing (decode, required, hardcoded)
import Json.Decode as Decode exposing (Decoder, andThen, succeed)
import Http exposing (Error)


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


type alias Paragraph =
    { type_ : ParagraphType
    , content : List String
    }


type ParagraphType
    = Normal
    | Logic


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
        [ { type_ = Normal
          , content =
                [ "Error loading the post" ]
          }
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
    decode Paragraph
        |> required "type" typeDecoder
        |> required "content" (Decode.list Decode.string)


typeDecoder : Decoder ParagraphType
typeDecoder =
    Decode.string
        |> andThen stringToParagraphType


stringToParagraphType : String -> Decoder ParagraphType
stringToParagraphType type_ =
    if type_ == "logic" then
        succeed Logic
    else
        succeed Normal
