module View.Post exposing (view)

import Html exposing (Html, div, p, text, br)
import Html.Attributes exposing (class, classList)
import Types.Post exposing (Model(..), Post, Paragraph(..), error)
import Types.Message exposing (Message(..))
import Components.NavBar as NavBar
import Util exposing ((:=))


view : Model -> List (Html Message)
view model =
    case model of
        HavePost titles post ->
            viewPost post

        _ ->
            { title = "Loading Post"
            , date = ""
            , body = []
            }
                |> viewPost


viewPost : Post -> List (Html Message)
viewPost post =
    [ NavBar.title
    , NavBar.view "Blog"
    , div
        [ class "post-body" ]
        (List.append (header post) (viewBody post))
    ]


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
                    ]
                ]
                (postSectionHelp i strings)

        Normal strings ->
            div
                [ classList
                    [ "post-section" := True
                    , "odd" := ((i % 2) == 1)
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
