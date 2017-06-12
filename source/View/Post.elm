module View.Post exposing (view)

import Html exposing (Html, Attribute, div, p, text, br, a, span)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Types.Post exposing (Model(..), Post, Paragraph(..), error)
import Types.Message exposing (Message(..))
import Types.Route as Route
import Route exposing (href)
import Components.NavBar as NavBar
import Util exposing ((:=))


view : Model -> List (Html Message)
view model =
    case model of
        HavePost titles post ->
            viewPost titles post

        _ ->
            { title = "Loading Post"
            , date = ""
            , body = []
            , number = 0
            }
                |> viewPost []


viewPost : List String -> Post -> List (Html Message)
viewPost titles post =
    [ NavBar.title
    , NavBar.view "Blog"
    , div
        [ class "post-body" ]
        (List.append (header post) (viewBody post))
    , archive titles post
    ]



-- ARCHIVE


archive : List String -> Post -> Html Message
archive titles post =
    List.append (viewTitles titles) (archiveButtons titles post)
        |> div [ class "archive-body" ]


archiveButtons : List String -> Post -> List (Html Message)
archiveButtons titles { number } =
    [ div
        [ class "archive-buttons" ]
        [ previousButton number
        , nextButton number (List.length titles)
        ]
    ]


previousButton : Int -> Html Message
previousButton number =
    let
        moreThanZero =
            number > 0

        route =
            Route.Post (number - 1)
    in
        a
            (buttonAttributes moreThanZero route)
            [ text "Previous" ]


nextButton : Int -> Int -> Html Message
nextButton number length =
    let
        lessThanLength =
            number < (length - 1)

        route =
            Route.Post (number + 1)
    in
        a
            (buttonAttributes lessThanLength route)
            [ text "Next" ]


buttonAttributes : Bool -> Route.Route -> List (Attribute Message)
buttonAttributes withinRange route =
    if withinRange then
        [ class "archive-button"
        , onClick (SetRoute (Just route))
        ]
    else
        [ class "archive-button nulled" ]



-- POST


viewTitles : List String -> List (Html Message)
viewTitles strings =
    List.indexedMap
        (viewTitle (List.length strings - 1))
        strings


viewTitle : Int -> Int -> String -> Html Message
viewTitle length postNumber title =
    a
        [ classList
            [ "title-listing" := True
            , "odd" := ((postNumber % 2) == 0)
            ]
        , href (Route.Post (length - postNumber))
        ]
        [ text title ]


viewBody : Post -> List (Html Message)
viewBody { body } =
    List.indexedMap postSection body


header : Post -> List (Html Message)
header { title, date } =
    [ titleView title
    , div
        [ class "post-section odd" ]
        [ p [] [ text date ] ]
    ]


titleView : String -> Html Message
titleView content =
    div
        [ class "post-section title" ]
        [ p [] [ text content ] ]


postSection : Int -> Paragraph -> Html Message
postSection i paragraph =
    case paragraph of
        Logic strings ->
            div
                [ classList
                    [ "post-section" := True
                    , "odd" := ((i % 2) == 0)
                    , "logic" := True
                    ]
                ]
                (postSectionHelp i strings)

        Normal strings ->
            div
                [ classList
                    [ "post-section" := True
                    , "odd" := ((i % 2) == 0)
                    ]
                ]
                (postSectionHelp i strings)

        _ ->
            Html.text ""


postSectionHelp : Int -> List String -> List (Html Message)
postSectionHelp i strings =
    case strings of
        head :: rest ->
            [ "* ", toString i, " ", head ]
                |> String.concat
                |> flip (::) rest
                |> List.map viewParagraph
                |> List.intersperse (br [] [])

        [] ->
            []


viewParagraph : String -> Html Message
viewParagraph str =
    p [] [ text str ]
