module Update exposing (..)

import Models exposing (..)
import Messages exposing (..)
import Cells.Update exposing (..)
import Cells.Messages exposing (..)
import Cells.Models exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    CellMsg rowIdx colIdx cellMsg ->
      case (cellMsg, model.gameState) of
        (BeginTurn, InProgress currentTurn) ->
          let newCells = updateGridElem (cellUpdate (EndTurn currentTurn)) rowIdx colIdx model.cells in
          ({model | cells = newCells, gameState = (gameState currentTurn newCells)}, Cmd.none)
        (_, _) -> (model, Cmd.none)

toggleTurn : Player -> Player
toggleTurn p =
  case p of
    X -> O
    O -> X

updateGridElem : (a -> a) -> Int -> Int -> List (List a) -> List (List a)
updateGridElem f rowIdx colIdx lst =
  let updateCol = updateListElem f colIdx in
  updateListElem updateCol rowIdx lst

updateListElem : (a -> a) -> Int -> List a -> List a
updateListElem f idx lst =
  case (idx, lst) of
    (_, []) -> []
    (0, (x::xs)) -> (f x)::xs
    (n, (x::xs)) -> x :: (updateListElem f (n-1) xs)

gameState : Player -> List (List CellModel) -> GameState
gameState lastPlayer cells =
  case cells |> List.concat |> (List.any isCellEmpty) of
    True -> InProgress (toggleTurn lastPlayer)
    False -> Finished
