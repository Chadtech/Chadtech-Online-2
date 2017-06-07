module Types.Post exposing (..)


type Model
    = Loading Int
    | Loaded Post


type alias Post =
    { title : String
    , date : String
    , body : List String
    , number : Int
    }
