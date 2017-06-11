module Update.Post exposing (..)

import Http
import Request.Post as Post
import Types.Post exposing (Model(..), Post, Message(..))


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case model of
        NoTitles maybePostNumber ->
            updateNoTitles message maybePostNumber

        HaveTitles titles maybePostNumber ->
            updateHaveTitles message titles maybePostNumber

        HavePost titles post ->
            updateHavePost message titles post


updateHavePost : Message -> List String -> Post -> ( Model, Cmd Message )
updateHavePost message titles post =
    case message of
        ConfigResponse (Ok newTitles) ->
            (HavePost newTitles post) ! []

        PostResponse (Ok newPost) ->
            (HavePost titles newPost) ! []

        _ ->
            (HavePost titles post) ! []


updateHaveTitles : Message -> List String -> Maybe Int -> ( Model, Cmd Message )
updateHaveTitles message titles maybePostNumber =
    let
        postNumber =
            case maybePostNumber of
                Nothing ->
                    List.length titles - 1

                Just number ->
                    number

        getPost =
            Http.send PostResponse (Post.get postNumber)
    in
        case message of
            ConfigResponse (Ok newTitles) ->
                (HaveTitles newTitles maybePostNumber) ! [ getPost ]

            PostResponse (Ok post) ->
                (HavePost titles post) ! []

            _ ->
                (HaveTitles titles maybePostNumber) ! [ getPost ]


updateNoTitles : Message -> Maybe Int -> ( Model, Cmd Message )
updateNoTitles message maybePostNumber =
    case message of
        ConfigResponse (Ok titles) ->
            let
                postNumber =
                    case maybePostNumber of
                        Nothing ->
                            List.length titles - 1

                        Just number ->
                            number
            in
                (HaveTitles titles maybePostNumber)
                    ! [ Http.send PostResponse (Post.get postNumber) ]

        _ ->
            (NoTitles maybePostNumber) ! []
