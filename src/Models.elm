module Models exposing (..)

import Cells.Models exposing (..)

type alias Model =
  {
    cells : List (List CellModel)
  , gameState : GameState
  }

type GameState =
  InProgress Player
  | Win Player
  | Draw

initialState : Model
initialState =
  {
    cells = List.repeat 3 (List.repeat 3 initEmpty)
  , gameState = InProgress X
  }
