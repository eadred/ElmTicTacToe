module Update exposing (update)

import Models exposing (..)
import Messages exposing (..)
import Cells.Update exposing (..)
import Cells.Messages exposing (..)
import Cells.Models exposing (..)
import GameLogic exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset -> ( initialState, Cmd.none )
    CellMsg rowIdx colIdx cellMsg ->
      case (cellMsg, model.gameState) of
        (BeginTurn, InProgress currentTurn) ->
          let newCells = updateGridElem (cellUpdate (EndTurn currentTurn)) rowIdx colIdx model.cells in
          ({model | cells = newCells, gameState = (gameState currentTurn newCells)}, Cmd.none)
        (_, _) -> (model, Cmd.none)

-- Internal functions

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
  case calculateWinner cells of
    Just p -> Win p -- Someone has won
    Nothing ->
      case cells |> List.concat |> (List.any isCellEmpty) of
        True -> InProgress (toggleTurn lastPlayer) -- It's the next player's turn
        False -> Draw -- The board is full so it's a draw

calculateWinner : List (List CellModel) -> Maybe Player
calculateWinner cells =
  cells
  |> List.indexedMap mapColumns
  |> List.concat
  |> List.map cellStatusToPlays
  |> List.concat
  |> checkWinner

mapColumns : Int -> List CellModel -> List (Int, Int, CellStatus)
mapColumns rowIndex columns =
  List.indexedMap (\colIndex cModel -> (rowIndex, colIndex, cModel.status)) columns

cellStatusToPlays : (Int, Int, CellStatus) -> List Play
cellStatusToPlays tuple =
  case tuple of
    (_, _, Empty) -> []
    (r, c, (Played p)) -> [{player = p, row = r, col = c}]
