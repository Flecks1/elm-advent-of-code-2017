module Utils.Html exposing (maybeToHtml, none)

import Html exposing (Html, text)


none : Html msg
none =
    text ""


maybeToHtml : (a -> Html msg) -> Maybe a -> Html msg
maybeToHtml toHtml =
    Maybe.map toHtml >> Maybe.withDefault none
