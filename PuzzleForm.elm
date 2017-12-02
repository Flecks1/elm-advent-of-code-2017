module PuzzleForm exposing (Model, Msg, make)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Result.Extra as Result
import Utils.Html as Html


-- Init


type alias Model outputType =
    { input : String
    , output : Maybe (Result String outputType)
    }


init : Model inputType
init =
    { input = "", output = Nothing }



-- Update


type Msg
    = InputText String
    | SubmitInput


update : (String -> Result String outputType) -> Msg -> Model outputType -> Model outputType
update fn msg model =
    case msg of
        InputText newInput ->
            { model | input = newInput }

        SubmitInput ->
            { model | output = Just (fn model.input) }



-- View


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : Model outputType -> Html Msg
view model =
    div [ style [ "padding" => "30px" ] ]
        [ p []
            [ label [ style [ "display" => "block" ] ]
                [ text "INPUT:"
                , textarea
                    [ onInput InputText
                    , rows 16
                    , style
                        [ "display" => "block"
                        , "border-radius" => "5px"
                        , "resize" => "none"
                        , "width" => "100%"
                        , "outline" => "0"
                        , "max-width" => "800px"
                        , "padding" => "5px"
                        ]
                    ]
                    [ text model.input ]
                ]
            , button
                [ onClick SubmitInput
                , style
                    [ "padding" => "8px 16px"
                    , "margin-top" => "10px"
                    ]
                ]
                [ text "Submit" ]
            ]
        , model.output
            |> Html.maybeToHtml (Result.unpack errorView outputView)
        ]


outputView : output -> Html Msg
outputView output =
    p [ style [ "color" => "green" ] ] [ text <| "OUTPUT: " ++ toString output ]


errorView : String -> Html Msg
errorView error =
    p [ style [ "color" => "red" ] ] [ text <| "ERROR: " ++ error ]



-- Make


make : (String -> Result String outputType) -> Program Never (Model outputType) Msg
make puzzleImplementation =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update puzzleImplementation
        }
