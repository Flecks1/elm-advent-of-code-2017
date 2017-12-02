module Main exposing (main)

import List.Extra as List
import Maybe.Extra as Maybe
import PuzzleForm


-- Puzzle relative


type alias Output =
    Int


puzzleImplementation : String -> Result String Output
puzzleImplementation input =
    input
        |> String.lines
        |> List.map (toInts >> differenceBetweenMinAndMax)
        |> List.sum
        |> Ok


toInts : String -> List Int
toInts =
    String.words
        >> Maybe.traverse (String.toInt >> Result.toMaybe)
        >> Maybe.withDefault []


differenceBetweenMinAndMax : List Int -> Int
differenceBetweenMinAndMax numberList =
    let
        sortedList =
            List.sort numberList
    in
    Maybe.map2 (-) (List.last sortedList) (List.head sortedList)
        |> Maybe.withDefault 0



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make puzzleImplementation
