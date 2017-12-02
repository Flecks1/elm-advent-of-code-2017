module Utils.Char exposing (toInt)

import Char


zeroCharCode : Int
zeroCharCode =
    48


toInt : Char -> Maybe Int
toInt char =
    if Char.isDigit char then
        Just (Char.toCode char - zeroCharCode)
    else
        Nothing
