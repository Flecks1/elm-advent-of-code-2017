module Main exposing (main)

import Dict exposing (Dict)
import Maybe.Extra as Maybe
import PuzzleForm


-- Puzzle relative


type alias Output =
    Int


parseInput : String -> Result String Int
parseInput input =
    input
        |> String.toInt
        |> Result.mapError (always "Input is not a number")


type alias MemoryCache =
    Dict ( Int, Int ) Int


writeValuesUntilTargetIsSurpassed : Int -> MemoryCache -> Int -> Int
writeValuesUntilTargetIsSurpassed memoryId cache target =
    let
        memoryLocation =
            getLocationOfMemory memoryId

        surroundingValues =
            getSurroundingLocations memoryLocation
                |> List.map (flip Dict.get cache)
                |> Maybe.values

        valueToBeWritten =
            case surroundingValues of
                [] ->
                    memoryId

                nonEmptyList ->
                    List.sum nonEmptyList
    in
    if valueToBeWritten > target then
        let
            _ =
                Debug.log "endingCache" cache
        in
        valueToBeWritten
    else
        writeValuesUntilTargetIsSurpassed (memoryId + 1) (cache |> Dict.insert memoryLocation valueToBeWritten) target


getSurroundingLocations : ( Int, Int ) -> List ( Int, Int )
getSurroundingLocations ( x, y ) =
    [ ( x - 1, y - 1 )
    , ( x, y - 1 )
    , ( x + 1, y - 1 )
    , ( x - 1, y )
    , ( x + 1, y )
    , ( x - 1, y + 1 )
    , ( x, y + 1 )
    , ( x + 1, y + 1 )
    ]



-- Getting memory identifier location


getLocationOfMemory : Int -> ( Int, Int )
getLocationOfMemory memoryId =
    let
        layer =
            getLayer memoryId

        segmentLength =
            getSegmentLength layer

        orderOnLayer =
            getOrderOnLayer memoryId

        segmentNumber =
            ceiling (toFloat orderOnLayer / toFloat segmentLength) - 1

        orderInSegment =
            orderOnLayer - segmentNumber * segmentLength
    in
    if memoryId == 1 then
        ( 0, 0 )
    else if segmentNumber == 0 then
        ( layer, layer - orderInSegment )
    else if segmentNumber == 1 then
        ( layer - orderInSegment, -layer )
    else if segmentNumber == 2 then
        ( -layer, orderInSegment - layer )
    else
        ( orderInSegment - layer, layer )


getDistance : ( Int, Int ) -> Int
getDistance ( x, y ) =
    abs x + abs y


getLayer : Int -> Int
getLayer =
    toFloat >> sqrt >> ceiling >> flip (//) 2


getOrderOnLayer : Int -> Int
getOrderOnLayer memoryId =
    memoryId - (((getLayer memoryId * 2) - 1) ^ 2)


getSegmentLength : Int -> Int
getSegmentLength layer =
    layer * 2



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make (parseInput >> Result.map (writeValuesUntilTargetIsSurpassed 1 Dict.empty))
