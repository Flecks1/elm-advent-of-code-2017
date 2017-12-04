module Main exposing (main)

import PuzzleForm
import Set


-- Puzzle relative


type alias Output =
    Int


type alias Passphrase =
    List String


parseInput : String -> Result String (List Passphrase)
parseInput input =
    input
        |> String.lines
        |> List.map String.words
        |> Ok


isValid : Passphrase -> Bool
isValid passphrase =
    let
        noTwoWordsAreTheSame =
            List.length passphrase == Set.size (Set.fromList passphrase)

        noTwoWordsAreAnagrams =
            not <| containsAnagrams passphrase
    in
        noTwoWordsAreTheSame && noTwoWordsAreAnagrams


containsAnagrams : Passphrase -> Bool
containsAnagrams passphrase =
    let
        containsAnagramsAux sortedWords =
            case sortedWords of
                [] ->
                    False

                word :: rest ->
                    List.any ((==) word) rest || containsAnagramsAux rest
    in
        passphrase
            |> List.map (String.toList >> List.sort >> String.fromList)
            |> containsAnagramsAux



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make (parseInput >> Result.map (List.filter isValid >> List.length))
