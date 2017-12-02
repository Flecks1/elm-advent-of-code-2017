module Main exposing (main)

import Maybe.Extra as Maybe
import PuzzleForm


-- Puzzle relative


type alias Output =
    Int


puzzleImplementation : String -> Result String Output
puzzleImplementation input =
    input
        |> toRows
        |> List.map (toInts >> firstWholeDivision)
        |> List.sum
        |> Ok


toRows : String -> List String
toRows =
    String.split "\n"


toInts : String -> List Int
toInts =
    String.split "\t"
        >> Maybe.traverse (String.toInt >> Result.toMaybe)
        >> Maybe.withDefault []


firstWholeDivision : List Int -> Int
firstWholeDivision ints =
    let
        ascendingList =
            List.sort ints

        descendingList =
            List.reverse ascendingList

        recurseOverDividends dividends =
            case dividends of
                dividend :: rest ->
                    case dividend |> findFactorInList ascendingList of
                        Just factor ->
                            dividend // factor

                        Nothing ->
                            recurseOverDividends rest

                [] ->
                    0
    in
    recurseOverDividends descendingList


{-| N.B. This function assumes that the candidates are already ordered in ascending order
-}
findFactorInList : List Int -> Int -> Maybe Int
findFactorInList candidates n =
    let
        isWorthTesting c =
            c <= n // 2

        isFactorOf n c =
            n % c == 0
    in
    case candidates of
        candidate :: rest ->
            if candidate |> isWorthTesting then
                if candidate |> isFactorOf n then
                    Just candidate
                else
                    n |> findFactorInList rest
            else
                Nothing

        [] ->
            Nothing



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make puzzleImplementation
