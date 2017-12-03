module Main exposing (main)

import PuzzleForm


-- Puzzle relative


type alias Output =
    Int


parseInput : String -> Result String Int
parseInput input =
    input
        |> String.toInt
        |> Result.mapError (always "Input is not a number")


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
    PuzzleForm.make (parseInput >> Result.map (getLocationOfMemory >> getDistance))
