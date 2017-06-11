module Types.Model exposing (Model(..))

import Types.Post as Post


type Model
    = Post Post.Model
    | Archive
    | Resume
    | Blank
    | NotFound
