module Models exposing (..)

import Cells.Models exposing (..)

type alias Model =
  {
    cells : List (List CellModel)
  , currentTurn : Player
  }
