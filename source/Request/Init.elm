module Request.Init exposing (..)

import Http exposing (Request)


getConfig : Request String
getConfig =
    Http.getString "http://www.chadtech.us/config.txt"
