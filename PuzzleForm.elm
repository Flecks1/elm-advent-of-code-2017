module PuzzleForm exposing (Model, Msg, make)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Result.Extra as Result
import Utils.Html as Html


-- Init


type alias Model inputType =
    { input : String
    , decodedInput : Maybe (Result String inputType)
    }


init : Model inputType
init =
    { input = "", decodedInput = Nothing }



-- Update


type Msg
    = InputText String
    | SubmitInput


update : Decoder dataType -> Msg -> Model dataType -> Model dataType
update inputDecoder msg model =
    case msg of
        InputText newInput ->
            { model | input = newInput }

        SubmitInput ->
            { model
                | decodedInput =
                    model.input
                        |> Decode.decodeString inputDecoder
                        |> Result.mapError (always "The input provided is not valid")
                        |> Just
            }



-- View


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : (dataType -> Result String output) -> Model dataType -> Html Msg
view fn model =
    div []
        [ p []
            [ label [ style [ "display" => "block" ] ]
                [ text "Input:"
                , textarea
                    [ onInput InputText, style [ "display" => "block" ] ]
                    [ text model.input ]
                ]
            , button [ onClick SubmitInput ] [ text "Submit" ]
            ]
        , model.decodedInput
            |> Html.maybeToHtml (Result.andThen fn >> Result.unpack errorView outputView)
        ]


outputView : output -> Html Msg
outputView output =
    p [ style [ "color" => "green" ] ] [ text <| "OUTPUT: " ++ toString output ]


errorView : String -> Html Msg
errorView error =
    p [ style [ "color" => "red" ] ] [ text <| "ERROR: " ++ error ]



-- Make


make : { r | implementation : dataType -> Result String output, inputDecoder : Decoder dataType } -> Program Never (Model dataType) Msg
make { implementation, inputDecoder } =
    Html.beginnerProgram
        { model = init
        , view = view implementation
        , update = update inputDecoder
        }
