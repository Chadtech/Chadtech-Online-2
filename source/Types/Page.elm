module Types.Page exposing (..)

import Types.Home as Home
import Types.Post as Post


type Page
    = Home Home.Model
    | Post Post.Model
    | Archive
    | Resume
    | NotFound
