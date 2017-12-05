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
    List.length passphrase == Set.size (Set.fromList passphrase)



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make (parseInput >> Result.map (List.filter isValid >> List.length))
