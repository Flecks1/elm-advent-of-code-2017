module Utils.String exposing (toSet)

import Set exposing (Set)


toSet : String -> Set Char
toSet =
    String.foldl Set.insert Set.empty
