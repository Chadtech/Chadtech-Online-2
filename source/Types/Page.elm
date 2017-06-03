module Types.Page exposing (..)

import Types.Home as Home


type Page
    = Home Home.Model
    | NotFound
