module Cells.Models exposing (..)

type alias CellModel = {status: CellStatus}

type CellStatus = Empty
                  | O
                  | X
