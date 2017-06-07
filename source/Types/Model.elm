module Types.Model exposing (Model)

import Types.Page exposing (Page)


type alias Model =
    { page : Page
    , postTitles : List String
    }
