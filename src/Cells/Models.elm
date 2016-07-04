module Cells.Models exposing (..)

type alias CellModel = {status: CellStatus}

type CellStatus = Empty
                  | Played Player

type Player = O | X

initEmpty : CellModel
initEmpty = {status = Empty}

playerText : Player -> String
playerText p =
  case p of
    O -> "O"
    X -> "X"
