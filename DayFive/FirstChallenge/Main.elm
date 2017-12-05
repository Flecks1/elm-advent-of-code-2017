module Main exposing (main)

import Array exposing (Array)
import PuzzleForm
import Utils.Result as Result


-- Puzzle relative


type alias Output =
    Int


type alias Maze =
    Array Int


parseInput : String -> Result String Maze
parseInput input =
    input
        |> String.lines
        |> Result.traverse String.toInt
        |> Result.map Array.fromList


goThroughMaze : Maze -> Int
goThroughMaze maze =
    let
        goThroughMazeAux maze currentPosition stepsTaken =
            case maze |> Array.get currentPosition of
                Just n ->
                    goThroughMazeAux
                        (maze |> Array.set currentPosition (n + 1))
                        (currentPosition + n)
                        (stepsTaken + 1)

                Nothing ->
                    stepsTaken
    in
    goThroughMazeAux maze 0 0



-- Main


main : Program Never (PuzzleForm.Model Output) PuzzleForm.Msg
main =
    PuzzleForm.make (parseInput >> Result.map goThroughMaze)
