module Types.Page exposing (..)

import Types.Post as Post


type Page
    = Post Post.Model
    | Archive
    | Resume
    | NotFound
