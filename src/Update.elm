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
      case cellMsg of
        BeginTurn ->
          let newCells = updateGridElem (cellUpdate (EndTurn model.currentTurn)) rowIdx colIdx model.cells in
          ({model | cells = newCells, currentTurn = toggleTurn model.currentTurn}, Cmd.none)
        _ -> (model, Cmd.none)

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
