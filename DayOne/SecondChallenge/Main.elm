module Main exposing (main)

import Maybe.Extra as Maybe
import PuzzleForm
import Utils.Char as Char


-- Puzzle relative


type alias Output =
    Int


isEven : Int -> Bool
isEven n =
    n % 2 == 0


puzzleImplementation : String -> Result String Output
puzzleImplementation input =
    let
        inputLength =
            String.length input
    in
    if inputLength |> isEven then
        input
            |> String.toList
            |> Maybe.traverse Char.toInt
            |> Result.fromMaybe "Input contains non-numeric characters"
            |> Result.map
                (\intList ->
                    let
                        ( firstHalf, secondHalf ) =
                            ( List.take (inputLength // 2) intList
                            , List.drop (inputLength // 2) intList
                            )
                    in
                    sumAllMatchingNumbers firstHalf secondHalf
                )
    else
        Err "The input is not of an even length"


sumAllMatchingNumbers : List Int -> List Int -> Int
sumAllMatchingNumbers list1 list2 =
    let
        mapFn a b =
            if a == b then
                a + b
            else
                0
    in
    List.map2 mapFn list1 list2 |> List.sum



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make puzzleImplementation
