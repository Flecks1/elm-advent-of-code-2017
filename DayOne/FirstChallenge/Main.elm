module Main exposing (main)

import Json.Decode as Decode exposing (Decoder)
import Maybe.Extra as Maybe
import PuzzleForm
import Utils.Char as Char


-- Puzzle relative


type alias Input =
    String


type alias Output =
    Int


inputDecoder : Decoder Input
inputDecoder =
    Decode.string


puzzleFunction : Input -> Result String Output
puzzleFunction input =
    input
        |> String.toList
        |> Maybe.traverse Char.toInt
        |> Result.fromMaybe "Input contains non-numeric characters"
        |> Result.map calculateSumOfAllNumbersThatMatchTheirSuccessor


calculateSumOfAllNumbersThatMatchTheirSuccessor : List Int -> Output
calculateSumOfAllNumbersThatMatchTheirSuccessor intList =
    let
        recursiveHelper firstInt currentSum currentList =
            case currentList of
                [] ->
                    0

                [ x ] ->
                    if x == firstInt then
                        currentSum + x
                    else
                        currentSum

                x :: ((y :: _) as rest) ->
                    if x == y then
                        recursiveHelper firstInt (currentSum + x) rest
                    else
                        recursiveHelper firstInt currentSum rest
    in
    case intList of
        [] ->
            0

        firstInt :: _ ->
            recursiveHelper firstInt 0 intList



-- Main


main : Program Never (PuzzleForm.Model Input) PuzzleForm.Msg
main =
    PuzzleForm.make
        { implementation = puzzleFunction
        , inputDecoder = inputDecoder
        }
